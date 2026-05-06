import qs.common
import Quickshell
import QtQuick
import qs.services

// generic popover with no mask support (hide on outside click)
PopupWindow {
    id: root
    required property Item anchorItem

    color: "transparent"

    // dynamically from children
    implicitWidth: contentItem.childrenRect.width + contentItem.childrenRect.x
    implicitHeight: contentItem.childrenRect.height + contentItem.childrenRect.y

    anchor.item: anchorItem
    anchor.rect.x: 0
    anchor.rect.y: anchorItem ? anchorItem.height + Config.spacing.marginGutterY : 0

    onVisibleChanged: {
        if (!visible)
            PopoverService.close(root);
        else
            PopoverService.open(root, () => root.visible = false);
    }

    function toggle() {
        root.visible = !root.visible;
    }
}
