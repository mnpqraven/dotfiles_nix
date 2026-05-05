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

        Text {
            text: 'ahihi'
        }
    }
}
