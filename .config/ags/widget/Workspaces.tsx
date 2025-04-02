import AstalHyprland from "gi://AstalHyprland";
import { bind } from "astal";

export function Workspaces() {
  const hypr = AstalHyprland.get_default();

  const wss = bind(hypr, "workspaces").as((wss) =>
    wss
      // filter out special workspaces
      .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
      .sort((a, b) => a.id - b.id),
  );

  return (
    <box cssClasses={["workspaces"]}>
      {wss.as((e) => e.map((ws) => <Workspace workspace={ws} />))}
    </box>
  );
}

interface WorkspaceProps {
  workspace: AstalHyprland.Workspace;
}
function Workspace({ workspace: ws }: WorkspaceProps) {
  const hypr = AstalHyprland.get_default();
  return (
    <button
      cssClasses={bind(hypr, "focusedWorkspace").as((fw) =>
        ws === fw ? ["focused"] : [""],
      )}
      onClicked={() => ws.focus()}
    >
      {ws.id}
    </button>
  );
}
