#!/usr/bin/env python3
"""Throwaway JSONL evidence ledger pilot; prints facts and writes nothing."""

from __future__ import annotations

import json
from collections import Counter
from pathlib import Path


ROOT = Path(__file__).parent
REQUIRED = {"id", "kind", "phase", "status", "claim", "source", "created_at"}


def load_jsonl(path: Path) -> list[dict]:
    records = []
    for line_number, line in enumerate(path.read_text().splitlines(), 1):
        if not line.strip():
            continue
        record = json.loads(line)
        missing = REQUIRED - record.keys()
        assert not missing, f"{path.name}:{line_number} missing {sorted(missing)}"
        assert isinstance(record["source"], list), f"{record['id']} source is not a list"
        records.append(record)
    return records


def stats(text: str) -> tuple[int, int, int]:
    encoded = text.encode()
    words = len(text.split())
    rough_tokens = (len(encoded) + 3) // 4
    return len(encoded), words, rough_tokens


def markdown_blocks(text: str) -> list[str]:
    return [block for block in text.split("\n## ")[1:] if block.strip()]


def main() -> None:
    shards = [ROOT / "agent-a.jsonl", ROOT / "agent-b.jsonl"]
    records = [record for shard in shards for record in load_jsonl(shard)]
    ids = [record["id"] for record in records]
    assert len(ids) == len(set(ids)), "duplicate record ID"

    by_id = {record["id"]: record for record in records}
    for record in records:
        for target in record.get("supersedes", []):
            assert target in by_id, f"{record['id']} supersedes unknown {target}"

    merged = sorted(records, key=lambda record: (record["created_at"], record["id"]))
    scoped = [record for record in merged if record["phase"] == "jsonl-pilot"]
    superseded = {
        target
        for record in scoped
        for target in record.get("supersedes", [])
    }
    active = [record for record in scoped if record["id"] not in superseded]
    pending = [record for record in active if record["status"] in {"open", "proposed"}]
    active_ids = {record["id"] for record in active}

    jsonl_text = "".join(path.read_text() + "\n" for path in shards)
    markdown_text = (ROOT / "baseline.md").read_text()
    scoped_markdown = "\n## ".join(
        block for block in markdown_blocks(markdown_text) if "phase: jsonl-pilot" in block
    )
    jsonl_selected = "\n".join(
        json.dumps(record, ensure_ascii=False, separators=(",", ":"))
        for record in scoped
    )

    print("JSONL evidence ledger pilot")
    print(f"streams: {len(shards)}; records: {len(records)}; unique_ids: pass")
    print(f"merged_order: {[record['id'] for record in merged]}")
    print(f"scoped_records: {len(scoped)}; unrelated_excluded: {'E-004' not in {r['id'] for r in scoped}}")
    print(f"superseded: {sorted(superseded)}; history_retains_superseded: {'E-001' in by_id and 'E-001' not in active_ids}; active_records: {len(active)}")
    print(f"pending_records: {[record['id'] for record in pending]}")
    print(f"kind_counts: {dict(Counter(record['kind'] for record in scoped))}")
    print(f"jsonl_full bytes/words/rough_tokens: {stats(jsonl_text)}")
    print(f"markdown_full bytes/words/rough_tokens: {stats(markdown_text)}")
    print(f"jsonl_scoped bytes/words/rough_tokens: {stats(jsonl_selected)}")
    print(f"markdown_scoped bytes/words/rough_tokens: {stats(scoped_markdown)}")
    print("limits: rough_tokens is bytes/4, not a tokenizer benchmark; writes were not concurrent")


if __name__ == "__main__":
    main()
