"use client";

import { useState } from "react";
import Wallpaper from "./(components)/Wallpaper";
import Taskbar98 from "./(components)/Taskbar98";
import Window98 from "./(components)/Window98";
import DesktopIcon from "./(components)/DesktopIcon";
import AixelPanel from "./(components)/AixelPanel";

export default function Home() {
  const [openWindow, setOpenWindow] = useState<string | null>(null);

  return (
    <>
      <Wallpaper />
      <Taskbar98 />
      <AixelPanel />

      {/* Desktop icons */}
      <div className="absolute top-4 left-4 space-y-6">
        <DesktopIcon
          title="Browser"
          icon="browser.png"
          onOpen={() => setOpenWindow("chromium-browser")}
        />
        <DesktopIcon
          title="Settings"
          icon="settings.png"
          onOpen={() => setOpenWindow("settings")}
        />
        <DesktopIcon
          title="Terminal"
          icon="terminal.png"
          onOpen={() => setOpenWindow("terminal")}
        />
      </div>

      {openWindow === "browser" && (
        <Window98 title="Browser">
          <p>MiniBrowser is handled outside the dashboard.</p>
        </Window98>
      )}

      {openWindow === "settings" && (
        <Window98 title="Settings">
          <p>Future J’SOS settings go here.</p>
        </Window98>
      )}
    </>
  );
}
