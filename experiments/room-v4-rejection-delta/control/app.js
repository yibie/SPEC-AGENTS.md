const KEY = 'room-v4-reservations';
const ROOMS = ['Atlas', 'Cedar', 'Juniper'];
const $ = (id) => document.getElementById(id);
const form = $('reservation-form'), list = $('reservation-list'), empty = $('empty-state'), message = $('form-message'), timeError = $('time-error');
let reservations = load(), pendingCancel = null;

function load() { try { const value = JSON.parse(localStorage.getItem(KEY) || '[]'); return Array.isArray(value) ? value : []; } catch { return []; } }
function save() { localStorage.setItem(KEY, JSON.stringify(reservations)); }
function values() { return { topic: $('topic').value.trim(), person: $('person').value.trim(), date: $('date').value, start: $('start').value, end: $('end').value, room: $('room').value }; }
function overlap(a, b) { return a.date === b.date && a.room === b.room && a.start < b.end && b.start < a.end; }
function validate(item, id = '') {
  timeError.textContent = item.start && item.end && item.end <= item.start ? 'End time must be after start time.' : '';
  if (timeError.textContent) return false;
  const conflict = reservations.find((r) => r.id !== id && r.status !== 'cancelled' && overlap(r, item));
  message.textContent = conflict ? 'That room is already reserved for this time.' : '';
  return !conflict;
}
function render() {
  list.replaceChildren();
  $('count').textContent = `${reservations.length} record${reservations.length === 1 ? '' : 's'}`;
  empty.hidden = reservations.length > 0;
  [...reservations].sort((a,b) => `${a.date}${a.start}`.localeCompare(`${b.date}${b.start}`)).forEach((r) => {
    const item = document.createElement('li'); item.className = `reservation ${r.status === 'cancelled' ? 'cancelled' : ''}`;
    const title = document.createElement('h3'); title.textContent = r.topic;
    const meta = document.createElement('p'); meta.className = 'meta'; meta.textContent = `${r.person} · ${r.room} · ${r.date} · ${r.start}–${r.end}`;
    const status = document.createElement('span'); status.className = 'status'; status.textContent = r.status === 'cancelled' ? 'Cancelled' : 'Active';
    item.append(title, meta, status);
    if (r.status !== 'cancelled') { const actions = document.createElement('div'); actions.className = 'actions record-actions'; const edit = document.createElement('button'); edit.type = 'button'; edit.textContent = 'Edit'; edit.addEventListener('click', () => editReservation(r.id)); const cancel = document.createElement('button'); cancel.type = 'button'; cancel.className = 'danger'; cancel.textContent = 'Cancel'; cancel.addEventListener('click', () => askCancel(r.id)); actions.append(edit, cancel); item.append(actions); }
    list.append(item);
  });
}
function editReservation(id) { const r = reservations.find((x) => x.id === id); if (!r) return; $('reservation-id').value = r.id; ['topic','person','date','start','end','room'].forEach((k) => $(k).value = r[k]); $('save-button').textContent = 'Save changes'; $('reset-button').hidden = false; $('form-heading').textContent = 'Edit reservation'; $('topic').focus(); }
function resetForm() { form.reset(); $('reservation-id').value = ''; $('save-button').textContent = 'Add reservation'; $('reset-button').hidden = true; $('form-heading').textContent = 'New reservation'; message.textContent = ''; timeError.textContent = ''; }
function askCancel(id) { const r = reservations.find((x) => x.id === id); if (!r) return; pendingCancel = id; $('cancel-copy').textContent = `Cancel “${r.topic}” in ${r.room} on ${r.date}? The record will be deleted.`; $('cancel-dialog').showModal(); }
form.addEventListener('submit', (event) => { event.preventDefault(); const item = values(); if (!form.reportValidity() || !validate(item, $('reservation-id').value)) return; const id = $('reservation-id').value; if (id) reservations = reservations.map((r) => r.id === id ? { ...r, ...item } : r); else reservations.push({ ...item, id: crypto.randomUUID(), status: 'active' }); save(); render(); resetForm(); message.textContent = 'Reservation saved.'; });
$('reset-button').addEventListener('click', resetForm);
// ponytail: D2 intentionally removes the record; retaining cancelled history requires a new product decision.
$('cancel-dialog').addEventListener('close', () => { if ($('cancel-dialog').returnValue === 'confirm' && pendingCancel) { reservations = reservations.filter((r) => r.id !== pendingCancel); save(); render(); } pendingCancel = null; });
render();
