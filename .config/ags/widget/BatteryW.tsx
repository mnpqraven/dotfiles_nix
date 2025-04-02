import { bind, GLib } from "astal";
import AstalBattery from "gi://AstalBattery";
import { percentage } from "../lib/utils";

export function BatteryW() {
  const batt = AstalBattery.get_default();

  const isOnBattery = bind(batt, "isBattery");

  if (!isOnBattery) return null;

  return (
    <box>
      <image iconName={GLib.get_os_info("LOGO") || "missing-symbolic"} />{" "}
      {bind(batt, "percentage").as(percentage)}
    </box>
  );
}
