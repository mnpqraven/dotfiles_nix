import AstalHyprland from "gi://AstalHyprland";
import { bind } from "astal";

export function Workspaces() {
  const hypr = AstalHyprland.get_default();

  return (
    <box cssClasses={["workspaces"]}>
      {bind(hypr, "workspaces").as((wss) =>
        wss
          .filter((ws) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
          .sort((a, b) => a.id - b.id)
          .map((ws) => (
            <button
              cssClasses={bind(hypr, "focusedWorkspace").as((fw) =>
                ws === fw ? ["focused"] : [""],
              )}
              onClicked={() => ws.focus()}
            >
              {ws.id}
            </button>
          )),
      )}
    </box>
  );
}
