import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.services

GridLayout {
    id: grid
    x: Config.spacing.marginGutterX
    y: Config.spacing.marginGutterY

    columns: 2
    uniformCellWidths: true
    columnSpacing: Config.spacing.gapItem
    rowSpacing: Config.spacing.gapItem

    Repeater {
        model: [
            {
                tagName: 'wifi'
            },
            {
                tagName: 'cf'
            },
            {
                tagName: 'noti'
            },
            {
                tagName: 'gamemode'
            },
        ]

        GridClicker {
            Layout.fillWidth: true
            Layout.fillHeight: true
            tagName: modelData.tagName
        }
    }
    component GridClicker: Rectangle {
        id: c
        property string tagName
        // probably better to use tri-state
        // see if we want support for more cases eg. error etc.
        // TODO: dyn
        property bool active: content.text === 'Connected'
        property bool loading

        radius: Config.spacing.barRadius
        // TODO: better color
        color: c.active ? Config.colCyan : Config.colMuted

        implicitWidth: row.implicitWidth + Config.spacing.marginGutterX * 2
        implicitHeight: row.implicitHeight + Config.spacing.marginGutterY * 2

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: c.tagOnclick(c.tagName)
        }

        RowLayout {
            id: row
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Config.spacing.marginGutterX
            spacing: Config.spacing.gapItem

            StyledText {
                text: c.getTagIcon(c.tagName)
                font.pixelSize: Config.spacing.barHeight
            }
            ColumnLayout {
                StyledText {
                    text: c.getTagName(c.tagName)
                }
                StyledText {
                    id: content

                    text: c.getTagContent(c.tagName, c.loading)

                    property string cfStatus: CloudflareService.status
                    onCfStatusChanged: {
                        if (c.tagName === 'cf')
                            c.loading = cfStatus === 'Connecting';
                    }
                }
            }
        }

        // WARN: this has mutation
        function getTagContent(tag: string, loading: bool): string {
            if (loading)
                return 'Loading...';

            switch (tag) {
            case "wifi":
                return 'TODO';
            case "cf":
                return CloudflareService.status;
            case "noti":
                return 'TODO';
            case "gamemode":
                return 'TODO';
            }
        }

        function getTagName(tag: string): string {
            switch (tag) {
            case "wifi":
                return 'Wifi';
            case "cf":
                return 'WARP';
            case "noti":
                return 'Notifications';
            case "gamemode":
                return 'Game mode';
            }
        }

        function getTagIcon(tag: string): string {
            switch (tag) {
            case "wifi":
                return '';
            case "cf":
                return '';
            case "noti":
                return '';
            case "gamemode":
                return '';
            }
        }

        function tagOnclick(tag: string) {
            switch (tag) {
            case "wifi":
                {
                    console.log('WARN: unimplemented');
                    return;
                }
            case "cf":
                {
                    if (CloudflareService.status === "Connected")
                        Quickshell.execDetached(["sh", "-c", "warp-cli disconnect"]);
                    else
                        Quickshell.execDetached(["sh", "-c", "warp-cli connect"]);

                    CloudflareService.refetch();
                }
            }
        }
    }
}
