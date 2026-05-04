import Quickshell.Services.UPower
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
        spacing: Config.spacing.gapItem
        anchors {
            left: parent.left
            leftMargin: Config.spacing.marginInnerBarX
            verticalCenter: parent.verticalCenter
        }
        StyledText {
            text: ''
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
        spacing: Config.spacing.gapItem
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    // right side
    RowLayout {
        spacing: Config.spacing.gapItem
        anchors {
            right: parent.right
            rightMargin: Config.spacing.marginInnerBarX
            verticalCenter: parent.verticalCenter
        }

        Volume {}

        StyledText {
            text: `CPU: ${CPU.usage}%`
        }

        StyledText {
            text: `MEM: ${Memory.usage}%`
        }

        Separator {}

        StyledText {
            text: Clock.time
        }

        Loader {
            active: UPower.displayDevice.isLaptopBattery
            sourceComponent: Battery {}
        }

        Power {}
    }
}
