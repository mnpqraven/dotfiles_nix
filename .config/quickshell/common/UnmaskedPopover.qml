import qs.common
import Quickshell
import QtQuick
import qs.services

// generic popover with no mask support (hide on outside click)
PopupWindow {
    id: root
    required property Item anchorItem

    property string side: 'bottom' // top | bottom | left | right
    property real opacity: exit.opacity

    visible: exit.shouldShow

    ExitAnimation {
        id: exit
    }

    color: "transparent"

    // dynamically from children
    implicitWidth: (contentItem.childrenRect.width + contentItem.childrenRect.x) || 100
    implicitHeight: (contentItem.childrenRect.height + contentItem.childrenRect.y) || 100

    anchor.item: anchorItem

    anchor.rect.x: rectFromSide(side, anchorItem).x
    anchor.rect.y: rectFromSide(side, anchorItem).y

    onVisibleChanged: {
        if (!visible)
            PopoverService.close(root);
        else
            PopoverService.open(root, () => exit.setVisible(false));
    }

    function toggle() {
        exit.setVisible(!exit.internalVisible);
    }

    function rectFromSide(side: string, anchor: Item): var {
        switch (side) {
        case 'top':
            return {
                x: 0,
                y: anchorItem ? 0 - Config.spacing.marginGutterY : 0
            };
        case 'bottom':
            return {
                x: 0,
                y: anchorItem ? anchorItem.height + Config.spacing.marginGutterY : 0
            };
        case 'left':
            return {
                x: anchorItem ? 0 - Config.spacing.marginGutterX : 0,
                y: 0
            };
        case 'right':
            return {
                x: anchorItem ? anchorItem.width + Config.spacing.marginGutterX : 0,
                y: 0
            };
        }
    }
}
