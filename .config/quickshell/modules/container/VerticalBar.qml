import QtQuick
import QtQuick.Layouts
import qs.modules.topbar
import qs.modules.panel
import qs.common

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
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: ev => popover.toggle()
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

                    Switcher {
                        opacity: popover.opacity
                    }
                    Calendar {
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }

    Net {}

    Power {}
}
