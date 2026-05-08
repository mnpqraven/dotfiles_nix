import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.common

// TODO: popover instead of repeater on bar
ColumnLayout {
    spacing: Config.spacing.widthUnit
    StyledText {
        text: '󰍁'
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: mouse => Quickshell.execDetached(["hyprlock"])
        }
    }
    StyledText {
        text: '󰜉'
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: mouse => Quickshell.execDetached(["sh", "-c", "reboot"])
        }
    }
    StyledText {
        text: '󰤆'
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: mouse => Quickshell.execDetached(["shutdown", "now"])
        }
    }
}
