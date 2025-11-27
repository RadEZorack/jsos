🚀 J’SOS — JavaScript Operating Shell

A minimalist Linux desktop shell powered by WebKit, Rust, and pure web technologies.

J’SOS (pronounced “Jay-Sauce”) is a lightweight, kiosk-style desktop shell for Linux built around one idea:

The operating system is a web page.

Your desktop, UI, apps, and workflows all live in a single HTML/JS environment, while native Linux apps remain fully accessible beneath the surface.

This repo contains the full J’SOS “Shell + Window Manager + Launcher” system used to replace the standard Ubuntu desktop with a fast, modern, web-driven experience.

🧠 Core Architecture
┌──────────────────────────────────────────────┐
│                  J’SOS Shell                 │
│         (HTML + CSS + JavaScript UI)         │
└──────────────────────────────────────────────┘
                 ↓ MiniBrowser
┌──────────────────────────────────────────────┐
│              WebKit2GTK MiniBrowser          │
│  (sandbox disabled, JS-driven desktop shell) │
└──────────────────────────────────────────────┘
                 ↓ Sway WM
┌──────────────────────────────────────────────┐
│              Wayland + Sway Window Manager   │
└──────────────────────────────────────────────┘
                 ↓ J’Core
┌──────────────────────────────────────────────┐
│          Rust Native App Launcher            │
│    `/run?app=name` → spawns desktop apps     │
└──────────────────────────────────────────────┘

✨ Features
🌐 Web-First Desktop

A full desktop environment written in HTML/JS/CSS rendered through MiniBrowser (WebKit engine).

⚡ Native App Launcher (Rust)

A tiny Rust HTTP server hands J’SOS the ability to launch real Linux apps:

GET http://127.0.0.1:21112/run?app=firefox

🪟 Sway WM Integration

Sway handles window management, hotkeys, and compositor duties using a minimal config.

🧩 Drop-in Extensibility

You can add new apps simply by:

Editing APP_MAP in the Rust launcher

Adding an icon + button in the HTML shell

🔍 Devtools Included

MiniBrowser supports WebKit Inspector (127.0.0.1:9223) for full debugging.

📦 Repository Structure
jsos/
 ├── jsos-shell/               # HTML/CSS/JS UI
 │    ├── index.html
 │    ├── apps/
 │    └── assets/
 │
 ├── jsos-wm/                  # Window manager configs
 │    ├── sway-config
 │    ├── jsos-session
 │    ├── jsos-launcher.rs     # Rust sourcemain launcher
 │    ├── jsos-launcher        # Compiled binary
 │    └── jsos.desktop
 │
 ├── installer/
 │    └── install.sh           # One-step setup
 │
 ├── README.md
 └── .gitignore

🔧 Installation

Prereqs:
Clean Ubuntu (or any modern Wayland distro)
webkit2gtk-4.1 installed (MiniBrowser provided by distro)

From inside Ubuntu:

git clone https://github.com/augmego/jsos
cd jsos/installer
./install.sh


Then log out → choose J’SOS from the login session menu.

🖥️ How to Develop
🚀 Start in Test Mode (inside Ubuntu)

Useful for debugging without logging out:

jsos-session

🛠 Edit Shell Code (HTML/CSS/JS)

Located in:

jsos-shell/


Just reload MiniBrowser to see changes.

⚙ Edit the Rust Launcher

Source file:

jsos-wm/jsos-launcher.rs


Recompile:

cd jsos-wm
cargo build --release
sudo cp target/release/jsos-launcher /usr/local/bin/

🧪 Add a New Native App

1️⃣ Add to Rust APP_MAP:

("sublime", "/usr/bin/subl"),
("firefox", "/usr/bin/firefox"),
("settings", "gnome-control-center"),


2️⃣ Add a button in index.html:

<button id="app-sublime" class="desktop-icon">Sublime</button>


3️⃣ Add JS handler:

document.getElementById("app-sublime")
    .addEventListener("click", () => launchNativeApp("sublime"));


Done.
Fully integrated native app.

🌱 Roadmap
1.0 → Shell & Bootstrapping

Basic HTML desktop

Native launcher

Firefox / Sublime / Terminal basics

Settings panel

Login session integration

1.5 → UI Expansion

Taskbar

App dock

Notifications

Multi-window support in JS shell

Web-apps as first-class programs

2.0 → J’Store & App Runtime

In-browser code editor (Monaco or custom)

“JSOS App Packages” that bundle HTML/CSS/JS

Sandboxed iframe runtime

Unified “system API” for apps

3.0 → Hardware Powered

Raspberry Pi reference build

Optional projector-monitor concept

Touch projection

Portable JSOS device

🤝 Contributing

Pull requests are welcome!
Roadmap discussions, UI mockups, shell features, and code contributions are all encouraged.

For bigger architectural ideas, open an Issue labeled proposal.

📜 License

MIT License.
Do whatever you want — build your own OS, fork it, remix it.