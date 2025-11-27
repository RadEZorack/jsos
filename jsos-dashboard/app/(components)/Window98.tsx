"use client";

import { useState } from "react";

export default function Window98({ title, children }: { title: string, children: React.ReactNode }) {
  const [minimized, setMinimized] = useState(false);

  if (minimized) return null;

  return (
    <div className="absolute top-32 left-32 window-98 shadow-lg w-[400px]">
      <div className="window-title flex justify-between items-center">
        <span>{title}</span>
        <div className="space-x-2">
          <button className="btn-98" onClick={() => setMinimized(true)}>_</button>
          <button className="btn-98" onClick={() => alert("Close clicked!")}>X</button>
        </div>
      </div>
      <div className="p-4 text-black">{children}</div>
    </div>
  );
}
