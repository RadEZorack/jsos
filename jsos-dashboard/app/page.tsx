"use client";

import { useState } from "react";
import Wallpaper from "./(components)/Wallpaper";
import Taskbar from "./(components)/Taskbar";
import Window from "./(components)/Window";
import DesktopIcon from "./(components)/DesktopIcon";
import AixelPanel from "./(components)/AixelPanel";

export default function Home() {
  const [openWindow, setOpenWindow] = useState<null | string>(null);

  return (
    <div>
      <Wallpaper />
      <Taskbar />
      <AixelPanel />

      {/* Desktop Icons */}
      <div className="absolute top-4 left-4 space-y-6">
        <DesktopIcon
          title="Browser"
          icon="browser.png"
          onOpen={() => setOpenWindow("browser")}
        />
        <DesktopIcon
          title="Settings"
          icon="settings.png"
          onOpen={() => setOpenWindow("settings")}
        />
      </div>

      {/* Window examples */}
      {openWindow === "browser" && (
        <Window title="Browser">
          <p>MiniBrowser is managed by JSOS, not here — but you can preview UI concepts here.</p>
        </Window>
      )}

      {openWindow === "settings" && (
        <Window title="Settings">
          <p>Future system settings go here.</p>
        </Window>
      )}
    </div>
  );
}
