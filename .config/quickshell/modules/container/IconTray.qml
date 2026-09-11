pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.common

GridLayout {
    id: root

    component AppEntry: QtObject {
        required property string name
        required property string launchArg
        property bool disabled: false
        property string desktopId: ''
        property string iconSource: ''
    }

    Repeater {
        // TODO:
        // get desktop id with
        // ls -l /run/current-system/sw/share/applications
        // ls -l /etc/profiles/per-user/othi/share/applications
        // nix derivative generate json configs
        // -> read from that json file
        model: [
            {
                name: 'Steam',
                launchArg: 'steam',
                disabled: true
            },
            {
                name: 'Easy Effects',
                launchArg: 'easyeffects',
                desktopId: 'com.github.wwmm.easyeffects'
            },
            // TODO: web browser based on features.nix
            {
                name: 'Zen',
                launchArg: 'zen-twilight',
                desktopId: 'zen-twilight.desktop'
            }
        ]
        ClickableIcon {}
    }

    component ClickableIcon: Rectangle {
        id: c

        property int size: 48
        required property var modelData
        property bool notShell

        radius: Config.spacing.barRadius
        // TODO: better color
        color: Config.colFg
        opacity: modelData.disabled ? 0.4 : 1

        implicitWidth: size
        implicitHeight: size

        readonly property string iconSource: {
            // reactively tracks desktop entries
            const apps = DesktopEntries.applications.values;
            if (c.modelData.desktopId?.length) {
                const entry = apps.length > 0 ? DesktopEntries.byId(c.modelData.desktopId) : null;
                return entry ? Quickshell.iconPath(entry.icon) : '';
            }
            if (c.modelData.iconSource?.length) {
                return Quickshell.iconPath(c.modelData.iconSource);
            }
            return '';
        }

        IconImage {
            anchors.centerIn: parent
            implicitSize: c.size - 12
            width: implicitSize
            height: implicitSize
            source: c.iconSource
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: c.modelData.disabled ? Qt.ArrowCursor : Qt.PointingHandCursor
            onClicked: function onClicked() {
                const args = c.notShell ? c.modelData.launchArg : ["sh", "-c", c.modelData.launchArg];
                Quickshell.execDetached(args);
            }
        }
    }
}
