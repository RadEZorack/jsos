"use client";

import { useEffect, useRef, useState } from "react";
import Wallpaper from "./(components)/Wallpaper";
import Taskbar98 from "./(components)/Taskbar98";
import Window98 from "./(components)/Window98";
import DesktopIcon from "./(components)/DesktopIcon";
import AixelPanel from "./(components)/AixelPanel";

export default function Home() {
  const [openWindow, setOpenWindow] = useState<string | null>(null);

  async function launchNativeApp(app: string) {
    await fetch(`http://127.0.0.1:21112/run?app=${encodeURIComponent(app)}`, {
      method: "GET"
    });
  }

  const launchingRef = useRef(false);

  useEffect(() => {
    if (!openWindow || launchingRef.current) return;

    launchingRef.current = true;

    launchNativeApp(openWindow)
      .catch(console.error)
      .finally(() => {
        launchingRef.current = false;
        setOpenWindow(null);
      });
  }, [openWindow]);



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
          onOpen={() => setOpenWindow("chromium")}
        />
        <DesktopIcon
          title="Settings"
          icon="settings.png"
          onOpen={() => setOpenWindow("gnome-control-center")}
        />
        <DesktopIcon
          title="Terminal"
          icon="terminal.png"
          onOpen={() => setOpenWindow("foot")}
        />
        <DesktopIcon
          title="Codium"
          icon="terminal.png"
          onOpen={() => setOpenWindow("/usr/bin/codium")}
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
