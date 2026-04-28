import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.topbar
import qs.common

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: 6
    margins.left: 12
    margins.right: 12

    implicitHeight: 30
    color: "transparent"

    // rounded edges
    Rectangle {
        anchors.fill: parent
        radius: 12
        color: "#0f0f17"
    }

    RowLayout {
        anchors.fill: parent

        // FIXME: margin instead of block
        Rectangle {
            width: 4
            color: "transparent"
        }

        Workspace {}

        WindowTitle {}

        Item {
            Layout.fillWidth: true
        }

        Text {
            text: `CPU: ${CPU.usage}%`
            color: Config.colFg
            font {
                family: Config.fontFamily
                pixelSize: Config.fontSize
                bold: true
            }
        }

        Rectangle {
            width: 2
            height: 16
            color: Config.colMuted
        }

        Text {
            text: Clock.time
            color: Config.colFg
            font {
                family: Config.fontFamily
                pixelSize: Config.fontSize
                bold: true
            }
        }

        // FIXME: margin instead of block
        Rectangle {
            width: 4
            color: "transparent"
        }
    }
}
