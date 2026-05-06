import qs.common
import QtQuick

StyledText {
    id: cf
    text: '󰦞 '

    MouseArea {
        anchors.fill: parent
        onClicked: ev => popover.toggle()
    }

    UnmaskedPopover {
        id: popover
        anchorItem: cf

        CardContainer {
            id: card

            StyledText {
                id: text
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY
                text: 'Cloudflare'
            }
        }
    }
}
