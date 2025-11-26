document.addEventListener("keydown", (e) => {
    if (e.ctrlKey && e.shiftKey && e.key === "i") {
        window.navigator.webkitStartDebugger();
    }
});
