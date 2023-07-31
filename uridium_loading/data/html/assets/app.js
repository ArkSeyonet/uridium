const background = $('#background');
let count = 0;
let faded = true;
let eventTriggered = false;

function fadeInBackground() {
  setTimeout(() => {
    window.requestAnimationFrame(() => {
      background.css({
        'opacity': '1.0',
        'transition': 'all 2.5s ease-in-out'
      });
    });
  }, 500);
}

function fadeOutBackground() {
  if (!eventTriggered) {
    eventTriggered = true;
    setTimeout(() => {
      window.requestAnimationFrame(() => {
        background.css({
          'opacity': '0.0',
          'transition': 'all 2.5s ease-in-out'
        });
      });
    }, 7000);
  }
}

window.addEventListener('load', function() {
  if (faded) {
    faded = false;
    fadeInBackground();
  }
});

window.addEventListener('message', (event) => {
  if (event.data.eventName === 'endInitFunction') {
    if (count < 2) {
      count++
    }
    
    if (count === 2) {
      fadeOutBackground();
    }
  }
});
