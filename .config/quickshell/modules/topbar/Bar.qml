import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.topbar
import qs.common

PanelWindow {
    id: root

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 30
    color: "transparent"

    // rounded edges
    Rectangle {
        anchors.fill: parent
        radius: 32
        color: "black"
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8

        Repeater {
            model: Niri.workspaces

            Rectangle {
                visible: index < 11
                width: 15
                height: 15
                radius: 15
                color: model.isActive ? Config.colCyan : Config.colMuted

                Text {
                    text: model.index
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Niri.focusWorkspaceById(model.id)
                }
            }
        }

        CPU {}
        Text {
            text: Clock.time
            color: "white"
        }
        Item {
            Layout.fillWidth: true
        }
    }
}
