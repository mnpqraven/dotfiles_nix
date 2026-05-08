pragma ComponentBehavior: Bound

import Quickshell.Networking
import QtQuick
import QtQuick.Layouts
import qs.common

StyledText {
    id: root
    text: Networking.wifiEnabled ? wifiStrengthIcon(wifiDevice.signalStrength) : "󰈀"

    property WifiNetwork wifiDevice: {
        // Neworking.devices -> NetworkDevice -> Network[]
        const nesteds = Networking.devices.values
        //
        .map(e => (e as NetworkDevice).networks)
        //
        .map(f => f.values).filter(f => f.length);

        for (let i = 0; i < nesteds.length; i++)
            for (let j = 0; j < nesteds[i].length; j++) {
                const nw = nesteds[i][j]; // WifiNetwork | Network
                // assign on first connected with signals
                if (nw.connected && nw.signalStrength !== null && nw.signalStrength > 0)
                    return nw;
            }
        return null;
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: root
        side: 'right'

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

                            // qmllint disable unresolved-type
                            // qmllint disable missing-property
                            text: (inner.networkDevice.type === DeviceType.Wifi ? root.wifiStrengthIcon(device.signalStrength) : "󰈀") + " " + device.name
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

    function wifiStrengthIcon(value: real): string {
        if (value >= 0.75)
            return '󰣺';
        if (value >= 0.5)
            return '󰣸';
        if (value >= 0.25)
            return '󰣶';
        if (value >= 0)
            return '󰣴';
    }
}
