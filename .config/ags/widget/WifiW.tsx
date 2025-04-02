import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Network from "gi://AstalNetwork";

export function WifiW() {
  const network = Network.get_default();
  const wifi = bind(network, "wifi");

  return (
    <box>
      {wifi.as((wifi) =>
        wifi ? (
          <menubutton
            hexpand
            halign={Gtk.Align.CENTER}
            tooltipText={bind(wifi, "ssid").as(String)}
            iconName={bind(wifi, "iconName")}
          >
            <popover>
              {/* TODO: */}
              <label label="TODO: wifi list" />
            </popover>
          </menubutton>
        ) : null,
      )}
    </box>
  );
}
