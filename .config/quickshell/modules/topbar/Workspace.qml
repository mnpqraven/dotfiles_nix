import Quickshell
import QtQuick
import qs.services
import qs.common

Repeater {
    readonly property string screenName: QsWindow.window?.screen?.name ?? ''

    model: Niri.workspaces

    Rectangle {
        visible: index < 11 && model.output === screenName
        width: 15
        height: 15
        radius: 15
        color: model.isActive ? Config.colCyan : Config.colMuted

        MouseArea {
            anchors.fill: parent
            onClicked: Niri.focusWorkspaceById(model.id)
        }
    }
}
