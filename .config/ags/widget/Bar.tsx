import { App, Astal, Gdk } from "astal/gtk4";
import { Workspaces } from "./Workspaces";
import { TimeW } from "./TimeW";
import { WifiW } from "./WifiW";
import { AudioW } from "./AudioW";
import { CurrentWindowName } from "./CurrentWindowName";
import { BatteryW } from "./BatteryW";
import { StatW } from "./StatW";
import { InputMethodW } from "./InputMethodW";

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
      <box cssName="centerbox">
        <box cssName="section">
          <Workspaces />
          <CurrentWindowName />
        </box>

        <box hexpand />

        <box cssName="section" cssClasses={["mpd"]} marginEnd={4}>
          TODO: mpd controller
        </box>

        <box cssName="section" hexpand={false}>
          <TimeW />
          <WifiW />
          <AudioW />
          <InputMethodW />
          <StatW />
          <BatteryW />
        </box>
      </box>
    </window>
  );
}
