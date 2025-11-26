// Simple update loop for the top bar clock
function updateClock() {
  const el = document.getElementById('time');
  const now = new Date();
  el.textContent = now.toLocaleTimeString();
}

setInterval(updateClock, 1000);
updateClock();
  