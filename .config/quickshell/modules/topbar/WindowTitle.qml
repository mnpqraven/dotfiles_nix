import QtQuick
import qs.services
import qs.common

StyledText {
    id: root
    property var currentWindow: Niri.focusedWindow
    elide: Text.ElideRight
    text: currentWindow?.title ?? ''

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function (mouseEvent) {
            if (mouseEvent.button === Qt.RightButton) {
                Niri.closeWindow(root.currentWindow.id);
            }
        }
    }
}
