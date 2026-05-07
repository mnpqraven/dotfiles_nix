import qs.common
import QtQuick

StyledText {
    id: cf
    text: '󰦞 '

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: ev => popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: cf

        CardContainer {
            id: card
            opacity: popover.opacity

            StyledText {
                id: text
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY
                text: 'Cloudflare'
            }
        }
    }
}
