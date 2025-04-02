import { bind } from "astal";
import Wp from "gi://AstalWp";

export function AudioW() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker;
  // TODO:
  // drag event
  // mute/unmute button
  // IO source selector
  // volume change handle
  // microphone change handle

  return (
    <menubutton>
      <popover>
        <slider
          hexpand
          step={1}
          min={0}
          max={100}
          digits={0}
          // onDragged={({ value }) => (speaker?.volume = value)}
          // value={bind(speaker, "volume")}
        />
      </popover>
    </menubutton>
  );
}
