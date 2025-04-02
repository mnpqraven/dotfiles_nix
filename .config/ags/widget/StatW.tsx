import { Variable } from "astal";
import { percentage } from "../lib/utils";

const divide = ([total, free]: [number, number]) => free / total;

const cpuCall = Variable("").poll(2000, "top -b -n 1");
const ramCall = Variable("").poll(2000, "free");
const cpu = Variable.derive([cpuCall], (cpu) => {
  const free = cpu
    .split("\n")
    .find((e) => e.includes("Cpu(s)"))
    ?.split(/\s/)
    .at(1)
    ?.replace(",", ".");
  const freeNum = free?.length && Number(free) !== 0 ? Number(free) : undefined;
  if (freeNum !== undefined) return divide([100, freeNum]);
  return 0;
});

const ram = Variable.derive([ramCall], (ram) => {
  const spliced = ram
    .split("\n")
    .find((line) => line.includes("Mem:"))
    ?.split(/\s+/)
    .splice(1, 2);
  if (spliced?.length !== 2) return 0;
  const [total, free] = spliced;
  if (Number(free) === 0) return 0;
  return divide([Number(total), Number(free)]);
});

export function StatW() {
  return (
    <box>
      cpu: {cpu().as(percentage)}
      mem: {ram().as(percentage)}
    </box>
  );
}
