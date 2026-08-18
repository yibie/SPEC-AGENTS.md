const ROOMS = ['Atlas', 'Cedar', 'Juniper'];
const KEY = 'room-v4-independent-ab-treatment';
const form = document.querySelector('#booking-form');
const list = document.querySelector('#booking-list');
const empty = document.querySelector('#empty');
const status = document.querySelector('#status');
const dialog = document.querySelector('#cancel-dialog');
const archiveToggle = document.querySelector('#archive-toggle');
let bookings = load();
let pendingCancel = null;
let showArchived = true;

function load() { try { const value = JSON.parse(localStorage.getItem(KEY)); return Array.isArray(value) ? value : []; } catch { return []; } }
function save() { localStorage.setItem(KEY, JSON.stringify(bookings)); }
function overlap(a, b) { return a.start < b.end && b.start < a.end; }
function conflict(candidate, ignoreId = '') { return bookings.some((b) => b.id !== ignoreId && b.lifecycle === 'active' && b.room === candidate.room && b.date === candidate.date && overlap(candidate, b)); }
function readForm() { const data = new FormData(form); return { topic: data.get('topic').trim(), person: data.get('person').trim(), date: data.get('date'), start: data.get('start'), end: data.get('end'), room: data.get('room') }; }
function validate(b, ignoreId = '') {
  const endError = document.querySelector('#end-error'); const formError = document.querySelector('#form-error'); endError.textContent = ''; formError.textContent = '';
  if (!b.topic || !b.person || !b.date || !b.start || !b.end || !ROOMS.includes(b.room)) { formError.textContent = 'Complete every field before saving.'; return false; }
  if (b.end <= b.start) { endError.textContent = 'End time must be later than start time.'; document.querySelector('#end').focus(); return false; }
  if (conflict(b, ignoreId)) { formError.textContent = 'That room is already reserved for this interval.'; document.querySelector(`[name="room"][value="${b.room}"]`).focus(); return false; }
  return true;
}
function resetForm() { form.reset(); document.querySelector('#booking-id').value = ''; document.querySelector('#save-button').textContent = 'Add reservation'; document.querySelector('#form-title').textContent = 'New reservation'; document.querySelector('#end-error').textContent = ''; document.querySelector('#form-error').textContent = ''; }
function render() {
  list.replaceChildren(); const active = bookings.filter((b) => b.lifecycle === 'active').length; const visible = bookings.filter((b) => showArchived || b.lifecycle === 'active'); document.querySelector('#count').textContent = `${active} active · ${bookings.length} total`; empty.hidden = visible.length > 0;
  [...visible].sort((a,b) => `${a.date}${a.start}`.localeCompare(`${b.date}${b.start}`)).forEach((b) => { const li = document.createElement('li'); li.className = `booking ${b.lifecycle}`; const title = document.createElement('h3'); title.textContent = b.topic; const meta = document.createElement('p'); meta.className = 'meta'; meta.textContent = `${b.date} · ${b.start}–${b.end} · ${b.room} · ${b.person}`; const badge = document.createElement('span'); badge.className = 'badge'; badge.textContent = b.lifecycle === 'active' ? 'Active' : 'Cancelled'; li.append(title, meta, badge); if (b.lifecycle === 'active') { const actions = document.createElement('div'); actions.className = 'booking-actions'; const edit = document.createElement('button'); edit.type = 'button'; edit.textContent = 'Edit'; edit.addEventListener('click', () => editBooking(b.id)); const cancel = document.createElement('button'); cancel.type = 'button'; cancel.className = 'secondary'; cancel.textContent = 'Cancel'; cancel.addEventListener('click', () => askCancel(b.id)); actions.append(edit, cancel); li.append(actions); } list.append(li); });
}
function editBooking(id) { const b = bookings.find((item) => item.id === id); if (!b) return; document.querySelector('#booking-id').value = b.id; for (const [key, value] of Object.entries(b)) { const input = form.elements[key]; if (!input) continue; if (input.length) [...input].forEach((radio) => { radio.checked = radio.value === value; }); else input.value = value; } document.querySelector('#form-title').textContent = 'Edit reservation'; document.querySelector('#save-button').textContent = 'Save changes'; document.querySelector('#booking-form').scrollIntoView({ block: 'start' }); document.querySelector('#topic').focus(); }
function askCancel(id) { pendingCancel = id; const b = bookings.find((item) => item.id === id); document.querySelector('#dialog-copy').textContent = `Cancel “${b.topic}” in ${b.room} on ${b.date}?`; dialog.showModal(); document.querySelector('#confirm-cancel').focus(); }
form.addEventListener('submit', (event) => { event.preventDefault(); const b = readForm(); const id = document.querySelector('#booking-id').value; if (!validate(b, id)) return; if (id) { const index = bookings.findIndex((item) => item.id === id); bookings[index] = { ...bookings[index], ...b }; status.textContent = 'Reservation updated.'; } else { bookings.push({ ...b, id: crypto.randomUUID(), lifecycle: 'active' }); status.textContent = 'Reservation added.'; } save(); render(); resetForm(); });
document.querySelector('#reset-button').addEventListener('click', resetForm);
document.querySelector('#confirm-cancel').addEventListener('click', () => { const b = bookings.find((item) => item.id === pendingCancel); if (b) { b.lifecycle = 'cancelled'; save(); render(); status.textContent = 'Reservation cancelled.'; } pendingCancel = null; dialog.close(); });
document.querySelector('#dismiss-cancel').addEventListener('click', () => { pendingCancel = null; dialog.close(); });
dialog.addEventListener('cancel', () => { pendingCancel = null; });
archiveToggle.addEventListener('click', () => { showArchived = !showArchived; archiveToggle.textContent = showArchived ? 'Hide archived' : 'Show archived'; archiveToggle.setAttribute('aria-pressed', String(showArchived)); render(); });
render();
