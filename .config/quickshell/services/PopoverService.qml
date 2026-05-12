pragma Singleton
import Quickshell
import QtQuick

// inspiration from MM-2103's service
// @see https://github.com/MM-2103/quickshell-bar/blob/master/PopupController.qml
Singleton {
    id: service

    property QtObject currentPopover: null
    property var currentCloseCallback: null

    function open(ref, closeCallback) {
        if (service.currentPopover === ref) {
            currentCloseCallback = closeCallback;
        }
        if (service.currentPopover) {
            // close currently opening popover on screen, regardless which one it is
            const closeOnScreen = service.currentCloseCallback;
            if (closeOnScreen)
                Qt.callLater(closeOnScreen);
        }
        currentPopover = ref;
        currentCloseCallback = closeCallback;
    }

    function close(ref) {
        if (currentPopover === ref) {
            currentPopover = null;
            currentCloseCallback = null;
        }
    }

    function closeAll() {
        const closeOnScreen = service.currentCloseCallback;
        if (closeOnScreen)
            Qt.callLater(closeOnScreen);
        currentPopover = null;
        currentCloseCallback = null;
    }
}
