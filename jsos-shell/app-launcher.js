async function launchNativeApp(app) {
    await fetch(`http://127.0.0.1:21112/run?app=${encodeURIComponent(app)}`);
}

document.getElementById("app-firefox").addEventListener("click", () => {
    launchNativeApp("firefox");
});

document.getElementById("app-terminal").addEventListener("click", () => {
    launchNativeApp("foot");
});

document.getElementById("app-settings").addEventListener("click", () => {
    launchNativeApp("settings");
});

document.getElementById("app-sublime").addEventListener("click", () => {
    launchNativeApp("sublime");
});