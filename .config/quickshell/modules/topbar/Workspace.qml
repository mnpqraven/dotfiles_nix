import Quickshell
import QtQuick
import qs.services
import qs.common

Repeater {
    id: ws
    readonly property string screenName: QsWindow.window?.screen?.name ?? ''

    // @see https://github.com/imiric/qml-niri/issues/14
    model: SortFilterProxyModel {
        id: filteredWorkspaces
        model: Niri.workspaces
        filters: [
            ValueFilter {
                roleName: "output"
                value: ws.screenName
                enabled: ws.screenName !== "" // show all when empty
            }
        ]
    }

    Rectangle {
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
