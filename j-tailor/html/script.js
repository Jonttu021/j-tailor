const keys = ['a', 's', 'd'];
const circles = {
    a: document.getElementById('circle-a'),
    s: document.getElementById('circle-s'),
    d: document.getElementById('circle-d')
};
let currentKey = null;
let score = 0;
const maxScore = 5;

function nextKey() {
    currentKey = keys[Math.floor(Math.random() * keys.length)];
    circles[currentKey].classList.add('active');
    startTimer()
}

let timerInterval = null;
let timerProgress = 0;

function startTimer() {
    timerProgress = 0;
    clearInterval(timerInterval);
    const speed = Math.max(20, 45 - (score * 5));
    timerInterval = setInterval(function() {
        timerProgress += 1;
        document.getElementById('timer-bar').style.width = timerProgress + '%';
        if (timerProgress >= 100) {
            clearInterval(timerInterval);
            document.getElementById('game').style.display = 'none';
            fetch('https://j-tailor/minigameResult', { method: 'POST', body: JSON.stringify({ success: false }) });
        }
    }, speed);
}

const audioCtx = new (window.AudioContext || window.webkitAudioContext)();

function playClick() {
    const oscillator = audioCtx.createOscillator();
    const gainNode = audioCtx.createGain();
    oscillator.connect(gainNode);
    gainNode.connect(audioCtx.destination);
    oscillator.frequency.value = 800;
    oscillator.type = 'sine';
    gainNode.gain.setValueAtTime(0.3, audioCtx.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + 0.1);
    oscillator.start(audioCtx.currentTime);
    oscillator.stop(audioCtx.currentTime + 0.1);
}

function playOpen() {
    const oscillator = audioCtx.createOscillator();
    const gainNode = audioCtx.createGain();
    oscillator.connect(gainNode);
    gainNode.connect(audioCtx.destination);
    oscillator.frequency.value = 400;
    oscillator.type = 'sine';
    gainNode.gain.setValueAtTime(0.2, audioCtx.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + 0.3);
    oscillator.start(audioCtx.currentTime);
    oscillator.stop(audioCtx.currentTime + 0.3);
}

function playSuccess() {
    const oscillator = audioCtx.createOscillator();
    const gainNode = audioCtx.createGain();
    oscillator.connect(gainNode);
    gainNode.connect(audioCtx.destination);
    oscillator.frequency.value = 600;
    oscillator.type = 'sine';
    gainNode.gain.setValueAtTime(0.3, audioCtx.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.001, audioCtx.currentTime + 0.5);
    oscillator.start(audioCtx.currentTime);
    oscillator.stop(audioCtx.currentTime + 0.5);
}

document.addEventListener('keydown', function(e) {
    e.stopPropagation();
    e.preventDefault();
    if (!currentKey) return;
    if (e.key === currentKey) {
        circles[currentKey].classList.remove('active');
        playClick()
        score++;
document.getElementById('score').textContent = score + ' / ' + maxScore;
if (score >= maxScore) {
    document.getElementById('game').style.display = 'none';
    playSuccess()
   fetch('https://j-tailor/minigameResult', { method: 'POST', body: JSON.stringify({ success: true }) });
} else {
    nextKey();
}
    }
});

window.addEventListener('message', function(e) {
    if (e.data.action === 'open') {
document.getElementById('game').style.display = 'block';
score = 0;
currentKey = null;
document.getElementById('score').textContent = '0 / ' + maxScore;
nextKey();
playOpen()
startTimer()
    }
});
