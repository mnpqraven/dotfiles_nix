pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.services

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
        // get desktop id by looping over DesktopEntries.applications.values
        model: [
            {
                name: 'Discord',
                launchArg: 'vesktop',
                desktopId: 'vesktop',
                enabled: true
            },
            {
                name: 'Steam',
                launchArg: 'steam',
                desktopId: 'steam',
                enabled: ConfigReaderService.gaming.enable
            },
            {
                name: 'Zen',
                launchArg: 'zen-beta',
                desktopId: 'zen-beta',
                enabled: ConfigReaderService.browser.zen.enabled
            },
            {
                name: 'Helium',
                launchArg: 'helium',
                desktopId: 'helium',
                enabled: ConfigReaderService.browser.helium.enabled
            },
            {
                name: 'Librewolf',
                launchArg: 'librewolf',
                desktopId: 'librewolf',
                enabled: ConfigReaderService.browser.librewolf.enabled
            },
            {
                name: 'Anki',
                launchArg: 'anki',
                desktopId: 'anki',
                enabled: true
            },
            {
                name: 'Syncthing',
                launchArg: 'syncthing browser',
                desktopId: 'syncthing-ui',
                enabled: ConfigReaderService.services.syncthing.enabled
            },
            {
                name: 'Deluge',
                launchArg: 'deluge',
                desktopId: 'deluge',
                enabled: true
            },
            {
                name: 'Dolphin',
                launchArg: 'dolphin',
                desktopId: 'org.kde.dolphin',
                enabled: true
            }
        ].filter(app => app.enabled)

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
                console.log('onclick', JSON.stringify(ConfigReaderService));
                const args = c.notShell ? c.modelData.launchArg : ["sh", "-c", c.modelData.launchArg];
                Quickshell.execDetached(args);
            }
        }
    }
}
