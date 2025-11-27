export default function DesktopIcon({ title, icon, onOpen }: { title: string, icon: string, onOpen: () => void }) {
  return (
    <div
      className="flex flex-col items-center w-20 text-center text-white cursor-pointer"
      onClick={onOpen}
    >
      <img src={`/icons/${icon}`} className="w-12 h-12" />
      <span className="mt-1 text-xs bg-black/40 px-1 rounded">{title}</span>
    </div>
  );
}
  