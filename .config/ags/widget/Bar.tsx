import { App, Astal, Gdk } from "astal/gtk4";
import { Workspaces } from "./Workspaces";
import { TimeW } from "./TimeW";
import { WifiW } from "./WifiW";
import { AudioW } from "./AudioW";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox cssName="centerbox">
        <Workspaces />

        <box hexpand />

        <box>
          <TimeW />
          <WifiW />
          <AudioW />
        </box>
      </centerbox>
    </window>
  );
}
