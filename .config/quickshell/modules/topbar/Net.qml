import Quickshell
import Quickshell.Networking
import QtQuick
import qs.common

StyledText {
    id: root
    text: "󰤨 "

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: root

        CardContainer {
            opacity: popover.opacity

            StyledText {
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY
                text: formattedConnectionStatus(Networking.connectivity)
            }
        }
    }

    function formattedConnectionStatus(conn): string {
        switch (conn) {
        case NetworkConnectivity.Full:
            return 'Full';
        case NetworkConnectivity.Portal:
            return 'Sign in needed';
        case NetworkConnectivity.Limited:
            return 'Limited';
        case NetworkConnectivity.Unknown:
            return 'Unknown';
        case NetworkConnectivity.None:
            return 'None';
        default:
            return 'hello';
        }
    }
}
