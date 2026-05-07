import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import qs.common

StyledText {
    id: root
    text: Networking.wifiEnabled ? "󰤨 " : "󰈀 "

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

            ColumnLayout {
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY

                StyledText {
                    text: root.formattedConnectionStatus(Networking.connectivity)
                }

                Repeater {
                    id: outer
                    model: Networking.devices

                    Repeater {
                        id: inner
                        // Neworking.devices -> NetworkDevice
                        required property NetworkDevice modelData
                        readonly property NetworkDevice networkDevice: modelData
                        model: modelData.networks

                        StyledText {
                            // NetworkDevice.networks -> Network
                            required property Network modelData
                            readonly property Network device: modelData

                            text: (inner.networkDevice.type === DeviceType.Wifi ? "󰤨 " : "󰈀 ") + device.name
                        }
                    }
                }
            }
        }
    }

    function formattedConnectionStatus(conn): string {
        switch (conn) {
        case NetworkConnectivity.Full:
            return 'Connected';
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
