import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
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

    MouseArea {
        anchors.fill: parent
        onClicked: ev => popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: root

        ColumnLayout {
            StyledText {
                text: 'Time to full: ' + prettifyDuration(UPower.displayDevice.timeToFull)
            }
            StyledText {
                text: 'Time to empty: ' + prettifyDuration(UPower.displayDevice.timeToEmpty)
            }
        }
    }

    /**
    * secs to `hr min`
    */
    function prettifyDuration(seconds) {
        const hr = Math.floor(seconds / 3600);
        const min = Math.floor((seconds % 3600) / 60);

        if (!hr)
            return `${min}m`;

        return `${hr}h ${min}m`;
    }
}
