import qs.common
import Quickshell
import QtQuick
import qs.services

// generic popover with no mask support (hide on outside click)
PopupWindow {
    id: root
    required property Item anchorItem

    property bool internalVisible
    property real opacity: internalVisible ? 1 : 0

    visible: internalVisible || mountAnimation.running

    // this should be the same as visible but changes {duration} after `visible` becomes false
    // same behaviour when `visible` becomes true
    Timer {
        id: mountAnimation
        interval: Config.animation.opacityDuration
        repeat: false
    }

    color: "transparent"

    // dynamically from children
    implicitWidth: (contentItem.childrenRect.width + contentItem.childrenRect.x) || 100
    implicitHeight: (contentItem.childrenRect.height + contentItem.childrenRect.y) || 100

    anchor.item: anchorItem
    anchor.rect.x: 0
    anchor.rect.y: anchorItem ? anchorItem.height + Config.spacing.marginGutterY : 0

    onInternalVisibleChanged: mountAnimation.restart()

    onVisibleChanged: {
        if (!visible)
            PopoverService.close(root);
        else
            PopoverService.open(root, () => root.internalVisible = false);
    }

    function toggle() {
        root.internalVisible = !root.internalVisible;
    }

    Behavior on opacity {
        NumberAnimation {
            duration: Config.animation.opacityDuration
            easing.type: Easing.OutCubic
        }
    }
}
