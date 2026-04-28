import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.topbar
import qs.common

PanelWindow {
    id: root

    required property var modelData
    screen: modelData

    anchors.top: true
    anchors.left: true
    anchors.right: true

    margins.top: Config.spacing.marginGutterY
    margins.left: Config.spacing.marginGutterX
    margins.right: Config.spacing.marginGutterX

    implicitHeight: Config.spacing.barHeight

    // rounded edges
    color: "transparent"
    Rectangle {
        anchors.fill: parent
        radius: Config.spacing.barRadius
        color: Config.colBg
    }

    // left side
    RowLayout {
        anchors {
            left: parent.left
            leftMargin: Config.spacing.marginInnerBarX
            verticalCenter: parent.verticalCenter
        }
        Text {
            text: ''
            font {
                pixelSize: Config.fontSize
            }
            color: Config.colFg

            MouseArea {
                anchors.fill: parent
                onClicked: mouse => Quickshell.execDetached(["sh", "-c", "$DEFAULT_TERMINAL"])
            }
        }

        Workspace {}

        WindowTitle {}
    }

    // center side
    // nothing yet
    RowLayout {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    // right side
    RowLayout {
        anchors {
            right: parent.right
            rightMargin: Config.spacing.marginInnerBarX
            verticalCenter: parent.verticalCenter
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

        Text {
            text: `MEM: ${Memory.usage}%`
            color: Config.colFg
            font {
                family: Config.fontFamily
                pixelSize: Config.fontSize
                bold: true
            }
        }

        Separator {}

        Text {
            text: Clock.time
            color: Config.colFg
            font {
                family: Config.fontFamily
                pixelSize: Config.fontSize
                bold: true
            }
        }
    }
}
