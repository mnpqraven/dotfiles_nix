import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.topbar
import qs.modules.container
import qs.common
import qs.ipc

// vertical left bar
ColumnLayout {
    required property Item squareAnchor

    Layout.alignment: Qt.AlignTop

    anchors {
        top: squareAnchor.bottom
        bottom: parent.bottom
        horizontalCenter: squareAnchor.horizontalCenter
        bottomMargin: Config.spacing.gapItem * 2
    }

    Rectangle {
        Layout.fillHeight: true
    }

    StyledText {
        id: root
        text: ''
        readonly property string screenName: QsWindow.window?.screen?.name ?? ''

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: ev => popover.toggle()
        }

        // register id to dict so IPC can open the command center
        onScreenNameChanged: {
            if (screenName)
                ControlCenterIpc.setControlPanelId(screenName, popover);
        }
        ControlPanelContainer {
            id: popover
            anchorItem: root
        }
    }

    Net {}

    Power {}
}
