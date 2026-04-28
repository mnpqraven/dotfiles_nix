import Quickshell
import QtQuick
import qs.services
import qs.common

Repeater {
    readonly property string screenName: QsWindow.window?.screen?.name ?? ''

    model: Niri.workspaces

    Rectangle {
        visible: model.output === screenName
        width: Config.spacing.barHeight / 2
        height: Config.spacing.barHeight / 2
        radius: Config.spacing.barRadius
        color: model.isActive ? Config.colCyan : Config.colMuted

        MouseArea {
            anchors.fill: parent
            onClicked: Niri.focusWorkspaceById(model.id)
        }
    }
}
