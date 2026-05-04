import Quickshell.Services.UPower
import QtQuick
import qs.common

StyledText {
    id: root
    property bool isCharging: !UPower.onBattery
    property real roundedPercent: Math.round(UPower.displayDevice.percentage * 100)
    property real fullAt: 95

    color: isCharging ? Config.colCyan : Config.colFg

    text: roundedPercent > fullAt ? getIcon(roundedPercent) : getIcon(roundedPercent) + roundedPercent + '%'

    function getIcon(percentage: real): string {
        const steps = [90, 70, 50, 30, 10];
        const icons = [" ", " ", " ", " ", " "];
        const curStep = steps.findIndex(num => percentage >= num);
        return icons[curStep];
    }
}
