(() => {
  'use strict';

  const durations = { focus: 25 * 60, short: 5 * 60, long: 15 * 60 };
  const display = document.querySelector('#timer-display');
  const status = document.querySelector('#timer-status');
  const startButton = document.querySelector('#start-button');
  const pauseButton = document.querySelector('#pause-button');
  const resetButton = document.querySelector('#reset-button');
  const modeInputs = [...document.querySelectorAll('input[name="mode"]')];

  let mode = 'focus';
  let remaining = durations[mode];
  let running = false;
  let ended = false;
  let endAt = 0;
  let tickId = 0;

  const formatTime = (seconds) => `${String(Math.floor(seconds / 60)).padStart(2, '0')}:${String(seconds % 60).padStart(2, '0')}`;
  const modeDuration = () => durations[mode];

  function renderTimer() {
    display.textContent = formatTime(Math.max(0, remaining));
    startButton.disabled = running || remaining === 0;
    pauseButton.disabled = !running;
    status.textContent = ended ? '已结束' : running ? '进行中' : remaining < modeDuration() ? '已暂停' : '准备开始';
  }

  function finishTimer() {
    running = false;
    ended = true;
    remaining = 0;
    window.clearInterval(tickId);
    if (mode === 'focus' && selectedTaskId) {
      const task = tasks.find((item) => item.id === selectedTaskId);
      if (task) { task.focusSessions += 1; persistTasks(); renderTasks(); }
    }
    renderTimer();
  }

  function tick() {
    if (!running) return;
    remaining = Math.max(0, Math.ceil((endAt - Date.now()) / 1000));
    if (remaining === 0) finishTimer();
    else renderTimer();
  }

  function startTimer() {
    if (running || remaining === 0) return;
    ended = false;
    running = true;
    endAt = Date.now() + remaining * 1000;
    tickId = window.setInterval(tick, 250);
    renderTimer();
  }

  function pauseTimer() {
    if (!running) return;
    tick();
    if (remaining > 0) {
      running = false;
      window.clearInterval(tickId);
      renderTimer();
    }
  }

  function resetTimer() {
    running = false;
    ended = false;
    window.clearInterval(tickId);
    remaining = modeDuration();
    renderTimer();
  }

  renderTimer();

  const storageKey = 'pomodoro-tasks-v1';
  const taskForm = document.querySelector('#task-form');
  const taskTitle = document.querySelector('#task-title');
  const taskError = document.querySelector('#task-error');
  const taskList = document.querySelector('#task-list');
  const emptyTasks = document.querySelector('#empty-tasks');
  const currentTask = document.querySelector('#current-task');
  const deleteDialog = document.querySelector('#delete-dialog');
  const deleteDescription = document.querySelector('#delete-description');
  let tasks = [];
  let selectedTaskId = null;
  let pendingDelete = null;

  try {
    const saved = JSON.parse(localStorage.getItem(storageKey) || '{}');
    tasks = Array.isArray(saved.tasks) ? saved.tasks.map((task) => ({ ...task, focusSessions: Number.isInteger(task.focusSessions) && task.focusSessions >= 0 ? task.focusSessions : 0 })) : [];
    selectedTaskId = saved.currentTaskId || null;
  } catch { taskError.textContent = '无法读取已保存任务。'; }

  function persistTasks() {
    try { localStorage.setItem(storageKey, JSON.stringify({ tasks, currentTaskId: selectedTaskId })); }
    catch { taskError.textContent = '无法保存任务。'; }
  }

  function renderTasks() {
    taskList.replaceChildren();
    emptyTasks.hidden = tasks.length > 0;
    const selected = tasks.find((task) => task.id === selectedTaskId);
    currentTask.textContent = `当前任务：${selected ? selected.title : '无'}`;
    tasks.forEach((task) => {
      const item = document.createElement('li');
      item.className = `task-item${task.completed ? ' completed' : ''}`;
      const select = document.createElement('input');
      select.type = 'radio'; select.name = 'current-task'; select.checked = task.id === selectedTaskId;
      select.setAttribute('aria-label', `选择当前任务：${task.title}`);
      select.addEventListener('change', () => { selectedTaskId = task.id; persistTasks(); renderTasks(); });
      const name = document.createElement('span'); name.className = 'task-name'; name.textContent = `${task.title} · 专注 ${task.focusSessions} 次`;
      const controls = document.createElement('span'); controls.className = 'task-controls';
      const toggle = document.createElement('button'); toggle.type = 'button'; toggle.textContent = task.completed ? '恢复' : '完成';
      toggle.addEventListener('click', () => { task.completed = !task.completed; persistTasks(); renderTasks(); });
      const edit = document.createElement('button'); edit.type = 'button'; edit.textContent = '编辑';
      edit.addEventListener('click', () => { const title = window.prompt('编辑任务', task.title); if (title !== null) { const next = title.trim(); if (next) { task.title = next; persistTasks(); renderTasks(); } else taskError.textContent = '任务名称不能为空。'; } });
      const remove = document.createElement('button'); remove.type = 'button'; remove.textContent = '删除';
      remove.addEventListener('click', () => { pendingDelete = task.id; deleteDescription.textContent = `确认删除“${task.title}”？`; deleteDialog.showModal(); });
      controls.append(toggle, edit, remove); item.append(select, name, controls); taskList.append(item);
    });
  }

  taskForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const title = taskTitle.value.trim();
    taskError.textContent = '';
    if (!title) { taskError.textContent = '任务名称不能为空。'; taskTitle.focus(); return; }
    tasks.push({ id: crypto.randomUUID(), title, completed: false, focusSessions: 0 });
    taskTitle.value = ''; persistTasks(); renderTasks(); taskTitle.focus();
  });

  deleteDialog.addEventListener('close', () => {
    if (deleteDialog.returnValue === 'confirm' && pendingDelete) {
      tasks = tasks.filter((task) => task.id !== pendingDelete);
      if (selectedTaskId === pendingDelete) selectedTaskId = null;
      persistTasks(); renderTasks();
    }
    pendingDelete = null;
  });

  modeInputs.forEach((input) => input.addEventListener('change', () => { if (durations[input.value]) { mode = input.value; resetTimer(); } }));
  startButton.addEventListener('click', startTimer);
  pauseButton.addEventListener('click', pauseTimer);
  resetButton.addEventListener('click', resetTimer);
  renderTasks();
})();
