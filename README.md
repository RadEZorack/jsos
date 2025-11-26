# J’SOS – JavaScript Operating Shell

The Second Coming of Computing™  
A JavaScript-first desktop environment built on top of Ubuntu, Sway, and WebKitGTK.

## What is J’SOS?

J’SOS is a modern, playful, human-friendly desktop environment written in:

- JavaScript
- HTML/CSS
- WebKitGTK
- Node.js
- Wayland (Sway)
- Rust (later for system-level bridges)

Ubuntu provides the kernel, drivers, and stability.
J’SOS provides the soul.

## Repo Structure

## Repo Structure

jsos/
├── jsos-shell/ # The HTML/JS desktop environment
├── jsos-wm/ # Sway/Wayland session files
├── jsos-services/ # System-level Node/Rust services
├── branding/ # Icons, wallpapers, visual identity
├── installer/ # Installer script for Ubuntu
└── docs/ # Architecture and concept documentation

perl
Copy code

## Quick Start

Install dependencies:

```bash
sudo apt install -y sway webkit2gtk webkit2gtk-driver nodejs npm
Launch J’SOS:

bash
Copy code
jsos-session
Vision
A computer that’s friendly, playful, intuitive, and powered by JavaScript.

This is just the beginning.

yaml
Copy code

---

# 📁 **jsos/docs/overview.md**

```markdown
# J’SOS: Overview

J’SOS is a JavaScript-based desktop environment designed for normal humans:
kids, elderly users, non-technical people, and anyone overwhelmed by traditional OSes.

## Core Ideas

- A desktop powered entirely by web technology.
- Every app is an HTML/JS bundle.
- AI assistants are part of the system.
- J’SOS feels alive, animated, interactive.
- Ubuntu handles the kernel/drivers; JS handles the experience.

## Architecture Layers

1. **Linux Kernel (Ubuntu)**
2. **Wayland (Sway)**
3. **WebKitGTK Shell**
4. **JS Desktop Environment**
5. **JS Apps + Node Services**

## Why JS?

- Easy to build experiences.
- Easy to animate.
- Universal dev skills.
- Fast iteration.
- Cross-platform.

J’SOS is to Ubuntu what ChromeOS is to Gentoo.
But fun.