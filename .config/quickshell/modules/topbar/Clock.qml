import QtQuick
import qs.common
import qs.services

StyledText {
    id: root
    text: ClockService.time

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: root

        CardContainer {
            // can this be parent.opacity ?
            opacity: popover.opacity

            StyledText {
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY
                text: ClockService.dateTime
            }
        }
    }
}
