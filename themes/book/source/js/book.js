function hide_canvas() {
    let sidebar = document.querySelector('.book-sidebar')
    let overlay = document.querySelector('.off-canvas-overlay')
    sidebar.classList.remove('show')
    overlay.classList.remove('show')
}

function open_sidebar() {
    let sidebar = document.querySelector('.book-sidebar')
    let overlay = document.querySelector('.off-canvas-overlay')
    sidebar.classList.add('show')
    overlay.classList.add('show')
}

function switch_theme() {
    let mode = localStorage.getItem('color-mode') || 'light';
    if (mode === 'dark') {
        let dark = document.createElement('link');
        dark.rel = 'stylesheet';
        dark.type = 'text/css';
        dark.href = '/tutorial/css/dark.css';
        dark.id = 'dark-mode';
        document.head.appendChild(dark);
    } else {
        let dark = document.getElementById('dark-mode');
        if (dark) {
            dark.remove();
        }
    }
}

switch_theme();

// watch for changes in the color-mode
window.addEventListener('storage', switch_theme);
