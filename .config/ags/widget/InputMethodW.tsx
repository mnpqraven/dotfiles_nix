import { exec, Variable } from "astal";
import { Gtk } from "astal/gtk4";

const fcitxIMs = Variable("").poll(2000, "fcitx5-remote -n");

type FcitxIMs = "keyboard-us" | "unikey" | "mozc";

type IMGroup = "us" | "vn" | "jp";
const groups: IMGroup[] = ["us", "vn", "jp"];

function toLabel(im: string): IMGroup | "" {
  switch (im as FcitxIMs) {
    case "keyboard-us":
      return "us";
    case "unikey":
      return "vn";
    case "mozc":
      return "jp";
    default:
      return "";
  }
}

export function InputMethodW() {
  return (
    <menubutton>
      <label label={fcitxIMs().as(toLabel)} />
      <popover>
        <box orientation={Gtk.Orientation.VERTICAL}>
          {groups.map((group) => (
            <button
              onClicked={() => {
                exec(`fcitx5-remote -g ${group}`);
              }}
            >
              {group}
            </button>
          ))}
        </box>
      </popover>
    </menubutton>
  );
}
