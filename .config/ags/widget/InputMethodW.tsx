import { Gtk } from "astal/gtk4";

export function InputMethodW() {
  function onSelect(kind: "default" | "colemak") {
    console.log("select mode", kind);
  }

  return (
    <menubutton>
      <label label="us" />
      <popover>
        <box orientation={Gtk.Orientation.VERTICAL}>
          <button onClicked={() => onSelect("default")}>us</button>
          <button onClicked={() => onSelect("colemak")}>colemak</button>
        </box>
      </popover>
    </menubutton>
  );
}
