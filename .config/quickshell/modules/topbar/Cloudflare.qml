import qs.common
import qs.services
import Quickshell
import QtQuick

StyledText {
    id: cf
    text: '󰦞' + screenName
    readonly property string screenName: QsWindow?.window?.screen?.name
    property var barRef: Panel.barDict?.[screenName]

    Component.onCompleted: () => {
        console.log('init', screenName);
    }

    MouseArea {
        anchors.fill: parent
        onClicked: ev => {
            // popover.visible = !popover.visible;
        }
    }

    // PopupWindow {
    //     id: popover
    //     color: Config.colBg
    //     visible: false

    //     // TODO: there should be a better way to do this
    //     anchor.window: cf.barRef
    //     anchor.rect.x: cf.mapToItem(cf.barRef.contentItem, 0, 0).x
    //     anchor.rect.y: cf.mapToItem(cf.barRef.contentItem, 0, 0).y + cf.height
    // }
}
