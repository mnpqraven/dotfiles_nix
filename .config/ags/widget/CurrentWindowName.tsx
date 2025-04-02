import { bind } from "astal";
import AstalHyprland from "gi://AstalHyprland";

export function CurrentWindowName() {
  const hypr = AstalHyprland.get_default();
  const windowBind = bind(hypr, "focusedClient").as((client) => client.title);

  return <label cssClasses={["current-name"]} label={windowBind} />;
}
