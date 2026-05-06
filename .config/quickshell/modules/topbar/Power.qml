import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.common

// TODO: popover instead of repeater on bar
RowLayout {
    spacing: Config.spacing.widthUnit
    StyledText {
        text: '󰍁 '
        MouseArea {
            anchors.fill: parent
            onClicked: mouse => Quickshell.execDetached(["sh", "-c", "hyprlock"])
        }
    }
    StyledText {
        text: '󰜉 '
        MouseArea {
            anchors.fill: parent
            onClicked: mouse => Quickshell.execDetached(["sh", "-c", "reboot"])
        }
    }
    StyledText {
        text: ' '
        MouseArea {
            anchors.fill: parent
            onClicked: mouse => Quickshell.execDetached(["shutdown", "now"])
        }
    }
}
