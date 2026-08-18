#!/usr/bin/env python3
"""Throwaway typed ontology graph pilot; prints state and writes nothing."""

from __future__ import annotations

from collections import deque


class OntologyError(Exception):
    pass


EDGE_TYPES = {
    "has_plan": ("Change", "Plan"),
    "captures": ("Plan", "SPEC"),
    "contains_slice": ("SPEC", "Slice"),
    "implements": ("Slice", "CodeArtifact"),
    "verified_by": ("CodeArtifact", "Verification"),
    "produces_evidence": ("Verification", "Evidence"),
    "constrains": ("Invariant", "ActionContract"),
    "implemented_by": ("ActionContract", "CodeArtifact"),
    "supports": ("Evidence", "Invariant"),
    "depends_on": ("ActionContract", "ActionContract"),
}

SEMANTIC_EDGES = {"constrains", "depends_on"}

ACTIONS = {
    "plan": ("Change", "candidate", "Plan", "draft", "has_plan", "planned", "active"),
    "capture": ("Plan", "active", "SPEC", "draft", "captures", "active", "captured"),
    "arrange": ("SPEC", "captured", "Slice", "pending", "contains_slice", "captured", "ready"),
    "do": ("Slice", "ready", "CodeArtifact", "unimplemented", "implements", "doing", "implemented"),
    "check": ("CodeArtifact", "implemented", "Verification", "pending", "verified_by", "implemented", "checked"),
    "learn": ("Verification", "checked", "Evidence", "pending", "produces_evidence", "checked", "recorded"),
}


class Graph:
    def __init__(self) -> None:
        self.nodes: dict[str, dict] = {}
        self.edges: dict[str, dict] = {}

    def add_node(self, node_id: str, node_type: str, state: str, label: str) -> None:
        assert node_id not in self.nodes, f"duplicate node: {node_id}"
        self.nodes[node_id] = {"type": node_type, "state": state, "label": label}

    def add_edge(
        self,
        edge_id: str,
        relation: str,
        source: str,
        target: str,
        *,
        status: str = "confirmed",
        source_ref: str,
        evidence: list[str] | None = None,
    ) -> None:
        if relation not in EDGE_TYPES:
            raise OntologyError(f"{relation} is an action or unknown relation")
        if edge_id in self.edges:
            raise OntologyError(f"duplicate edge: {edge_id}")
        if source not in self.nodes or target not in self.nodes:
            raise OntologyError("edge endpoint is not a node")
        expected_source, expected_target = EDGE_TYPES[relation]
        actual_source = self.nodes[source]["type"]
        actual_target = self.nodes[target]["type"]
        if (actual_source, actual_target) != (expected_source, expected_target):
            raise OntologyError(
                f"{relation} expects {expected_source}->{expected_target}, "
                f"got {actual_source}->{actual_target}"
            )
        evidence = list(evidence or [])
        if status == "confirmed" and relation in SEMANTIC_EDGES and not evidence:
            raise OntologyError(f"confirmed {relation} requires Evidence")
        for evidence_id in evidence:
            if self.nodes.get(evidence_id, {}).get("type") != "Evidence":
                raise OntologyError(f"unknown Evidence: {evidence_id}")
        self.edges[edge_id] = {
            "relation": relation,
            "source": source,
            "target": target,
            "status": status,
            "source_ref": source_ref,
            "evidence": evidence,
        }

    def apply_action(self, action: str, source: str, target: str, edge_id: str) -> None:
        if action not in ACTIONS:
            raise OntologyError(f"unknown action: {action}")
        source_type, source_state, target_type, target_state, relation, source_after, target_after = ACTIONS[action]
        source_node = self.nodes[source]
        target_node = self.nodes[target]
        if source_node["type"] != source_type or target_node["type"] != target_type:
            raise OntologyError(f"{action} has the wrong object types")
        if source_node["state"] != source_state or target_node["state"] != target_state:
            raise OntologyError(
                f"{action} requires {source_state}/{target_state}, "
                f"got {source_node['state']}/{target_node['state']}"
            )
        self.add_edge(edge_id, relation, source, target, source_ref=f"action:{action}")
        source_node["state"] = source_after
        target_node["state"] = target_after

    def reject_edge(self, edge_id: str, evidence_id: str) -> None:
        edge = self.edges[edge_id]
        if edge["status"] != "proposed":
            raise OntologyError("only proposed edges can be rejected")
        if self.nodes.get(evidence_id, {}).get("type") != "Evidence":
            raise OntologyError(f"unknown Evidence: {evidence_id}")
        edge["status"] = "rejected"
        edge["evidence"].append(evidence_id)

    def active_edges(self) -> list[tuple[str, dict]]:
        return [(edge_id, edge) for edge_id, edge in self.edges.items() if edge["status"] == "confirmed"]

    def impact(self, start: str) -> list[str]:
        reached: list[str] = []
        seen = {start}
        queue = deque([start])
        while queue:
            current = queue.popleft()
            for _, edge in self.active_edges():
                if edge["source"] != current or edge["target"] in seen:
                    continue
                seen.add(edge["target"])
                reached.append(edge["target"])
                queue.append(edge["target"])
        return reached

    def validate(self) -> None:
        for edge in self.edges.values():
            expected = EDGE_TYPES[edge["relation"]]
            actual = (self.nodes[edge["source"]]["type"], self.nodes[edge["target"]]["type"])
            assert actual == expected, (edge, actual, expected)
            assert edge["source_ref"], edge
            for evidence_id in edge["evidence"]:
                assert self.nodes[evidence_id]["type"] == "Evidence", evidence_id


def build_graph() -> Graph:
    graph = Graph()
    nodes = [
        ("C-1", "Change", "candidate", "Add a task-list action"),
        ("P-1", "Plan", "draft", "Confirmed change plan"),
        ("S-1", "SPEC", "draft", "Task-list design contract"),
        ("SL-1", "Slice", "pending", "Task-list slice"),
        ("CA-1", "CodeArtifact", "unimplemented", "Task-list implementation"),
        ("V-1", "Verification", "pending", "Task-list verification"),
        ("E-0", "Evidence", "recorded", "Existing evidence for the invariant"),
        ("E-1", "Evidence", "pending", "New runtime evidence"),
        ("E-2", "Evidence", "recorded", "Evidence rejecting an alternative dependency"),
        ("I-1", "Invariant", "active", "A Change must be planned before do"),
        ("AC-do", "ActionContract", "active", "do action contract"),
        ("AC-check", "ActionContract", "active", "check action contract"),
    ]
    for node in nodes:
        graph.add_node(*node)
    return graph


def expect_failure(label: str, operation) -> None:
    try:
        operation()
    except OntologyError as error:
        print(f"{label}: pass ({error})")
    else:
        raise AssertionError(f"{label}: expected OntologyError")


def main() -> None:
    graph = build_graph()
    print("Ontology graph projection pilot")
    print(f"initial nodes: {len(graph.nodes)}")

    expect_failure(
        "actions are not relations",
        lambda: graph.add_edge("R-invalid-action", "plan", "C-1", "P-1", source_ref="bad"),
    )
    expect_failure(
        "domain/range check",
        lambda: graph.add_edge("R-invalid-range", "has_plan", "CA-1", "P-1", source_ref="bad"),
    )
    expect_failure(
        "lifecycle gate before arrange",
        lambda: graph.apply_action("do", "SL-1", "CA-1", "R-do-early"),
    )

    sequence = [
        ("plan", "C-1", "P-1", "R-plan"),
        ("capture", "P-1", "S-1", "R-capture"),
        ("arrange", "S-1", "SL-1", "R-arrange"),
        ("do", "SL-1", "CA-1", "R-do"),
        ("check", "CA-1", "V-1", "R-check"),
        ("learn", "V-1", "E-1", "R-learn"),
    ]
    for action, source, target, edge_id in sequence:
        graph.apply_action(action, source, target, edge_id)
        print(f"after {action}: {source}={graph.nodes[source]['state']}, {target}={graph.nodes[target]['state']}")

    graph.add_edge("R-supports", "supports", "E-0", "I-1", source_ref="E-0")
    graph.add_edge("R-constrains", "constrains", "I-1", "AC-do", source_ref="CONTEXT.md", evidence=["E-0"])
    graph.add_edge("R-implements-contract", "implemented_by", "AC-do", "CA-1", source_ref="CONTEXT.md")
    graph.add_edge("R-depends-candidate", "depends_on", "AC-do", "AC-check", status="proposed", source_ref="review")
    graph.reject_edge("R-depends-candidate", "E-2")
    graph.validate()

    impact = graph.impact("I-1")
    provenance = graph.edges["R-constrains"]["evidence"]
    active_dependencies = [
        edge_id
        for edge_id, edge in graph.active_edges()
        if edge["relation"] == "depends_on"
    ]
    assert impact == ["AC-do", "CA-1", "V-1", "E-1"], impact
    assert provenance == ["E-0"], provenance
    assert active_dependencies == [], active_dependencies
    assert graph.edges["R-depends-candidate"]["status"] == "rejected"

    print(f"confirmed impact from I-1: {impact}")
    print(f"R-constrains evidence: {provenance}")
    print("rejected candidate remains inspectable: pass")
    print(f"active depends_on edges: {active_dependencies}")
    print("limits: in-memory only; no concurrent writes, inference, or database behavior tested")


if __name__ == "__main__":
    main()
