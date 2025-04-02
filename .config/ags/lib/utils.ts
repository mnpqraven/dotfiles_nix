/**
 * @param num float ranging from 0 to 1
 */
export function percentage(num: number, fixedLen = 0): string {
  const per = num * 100;
  return per.toFixed(fixedLen) + " %";
}
