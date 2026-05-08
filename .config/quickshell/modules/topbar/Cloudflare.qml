import qs.common
import QtQuick

StyledText {
    id: root
    text: '󰦞 '

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: ev => popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: root

        CardContainer {
            id: card
            opacity: popover.opacity

            StyledText {
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY
                text: 'Cloudflare'
            }
        }
    }
}
