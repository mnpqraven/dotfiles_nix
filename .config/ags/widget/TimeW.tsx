import { Variable } from "astal";
import { Gtk } from "astal/gtk4";

const time = Variable("").poll(1000, "date +%T");
const fullTime = Variable("").poll(1000, "date '+%d %b %T'");
const isFull = Variable(false);

const dynTime = Variable.derive(
  [time, fullTime, isFull],
  (_time, _fullTime, _full) => (_full ? _fullTime : _time),
);

function down() {
  time.drop();
  fullTime.drop();
  isFull.drop();
  dynTime.drop();
}

export function TimeW() {
  function onHover(state: boolean) {
    if (state) fullTime.startPoll();
    else fullTime.stopPoll();
    isFull.set(state);
  }

  return (
    <menubutton
      hexpand
      halign={Gtk.Align.CENTER}
      onHoverEnter={() => onHover(true)}
      onHoverLeave={() => onHover(false)}
      onDestroy={down}
    >
      <label label={dynTime()} />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  );
}
