(() => {
  'use strict';
  const ROOMS = ['Atlas', 'Cedar', 'Juniper'];
  const KEY = 'meeting-room-reservations-v1';
  const $ = (id) => document.getElementById(id);
  const form = $('reservation-form');
  const fields = { id: $('reservation-id'), topic: $('topic'), person: $('person'), date: $('date'), room: $('room'), start: $('start'), end: $('end') };
  let reservations = load();
  let pendingCancellation = null;

  ROOMS.forEach((room) => $('room').add(new Option(room, room)));
  fields.date.value = new Date().toISOString().slice(0, 10);

  function load() {
    try { const value = JSON.parse(localStorage.getItem(KEY) || '[]'); return Array.isArray(value) ? value : []; }
    catch { return []; }
  }
  function persist() { localStorage.setItem(KEY, JSON.stringify(reservations)); }
  function timeValue(time) { const [h, m] = time.split(':').map(Number); return h * 60 + m; }
  function showError(message) { $('form-error').textContent = message; }
  function validate(candidate) {
    if (!candidate.topic.trim() || !candidate.person.trim() || !candidate.date || !candidate.room || !candidate.start || !candidate.end) return 'Complete every field.';
    if (timeValue(candidate.end) <= timeValue(candidate.start)) return 'End time must be later than start time.';
    const clash = reservations.find((r) => !r.cancelled && r.id !== candidate.id && r.date === candidate.date && r.room === candidate.room && timeValue(candidate.start) < timeValue(r.end) && timeValue(candidate.end) > timeValue(r.start));
    return clash ? `That time overlaps the reservation for ${clash.topic}.` : '';
  }
  function resetForm() { form.reset(); fields.id.value = ''; fields.date.value = new Date().toISOString().slice(0, 10); $('save-button').textContent = 'Save reservation'; $('clear-button').hidden = true; showError(''); }
  function edit(id) { const r = reservations.find((item) => item.id === id); if (!r) return; Object.keys(fields).forEach((key) => { if (fields[key]) fields[key].value = r[key] || ''; }); $('save-button').textContent = 'Update reservation'; $('clear-button').hidden = false; showError(''); fields.topic.focus(); }
  function render() {
    const list = $('reservation-list'); list.replaceChildren(); $('empty-state').hidden = reservations.length > 0; $('count').textContent = reservations.length ? `${reservations.length} record${reservations.length === 1 ? '' : 's'}` : '';
    [...reservations].sort((a, b) => `${a.date}${a.start}`.localeCompare(`${b.date}${b.start}`)).forEach((r) => {
      const article = document.createElement('article'); article.className = `reservation${r.cancelled ? ' cancelled' : ''}`;
      const title = document.createElement('h3'); title.textContent = r.topic; article.append(title);
      const status = document.createElement('span'); status.className = 'status'; status.textContent = r.cancelled ? 'Cancelled' : 'Active'; article.append(status);
      const details = document.createElement('p'); details.textContent = `${r.person} · ${r.room} · ${r.date} · ${r.start}–${r.end}`; article.append(details);
      if (!r.cancelled) { const actions = document.createElement('div'); actions.className = 'card-actions'; const editButton = document.createElement('button'); editButton.type = 'button'; editButton.className = 'secondary'; editButton.textContent = 'Edit'; editButton.addEventListener('click', () => edit(r.id)); const cancelButton = document.createElement('button'); cancelButton.type = 'button'; cancelButton.textContent = 'Cancel reservation'; cancelButton.addEventListener('click', () => openCancellation(r.id)); actions.append(editButton, cancelButton); article.append(actions); }
      list.append(article);
    });
  }
  function openCancellation(id) { pendingCancellation = id; const dialog = $('cancel-dialog'); if (typeof dialog.showModal === 'function') dialog.showModal(); else if (window.confirm('Cancel this reservation?')) confirmCancellation(); }
  function closeDialog() { const dialog = $('cancel-dialog'); if (dialog.open) dialog.close(); pendingCancellation = null; }
  function confirmCancellation() { const r = reservations.find((item) => item.id === pendingCancellation); if (r) { r.cancelled = true; persist(); render(); } closeDialog(); }
  form.addEventListener('submit', (event) => { event.preventDefault(); const candidate = { id: fields.id.value || crypto.randomUUID(), topic: fields.topic.value, person: fields.person.value, date: fields.date.value, room: fields.room.value, start: fields.start.value, end: fields.end.value, cancelled: false }; const error = validate(candidate); if (error) { showError(error); return; } const index = reservations.findIndex((r) => r.id === candidate.id); if (index >= 0) reservations[index] = candidate; else reservations.push(candidate); persist(); render(); resetForm(); });
  $('clear-button').addEventListener('click', resetForm);
  $('confirm-cancel').addEventListener('click', confirmCancellation);
  $('dismiss-cancel').addEventListener('click', closeDialog);
  $('cancel-dialog').addEventListener('close', () => { pendingCancellation = null; });
  render();
})();
