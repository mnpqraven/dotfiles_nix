import QtQuick
import qs.services
import qs.common

Text {
    id: root
    property var currentWindow: Niri.focusedWindow
    text: currentWindow?.title ?? ''
    color: Config.colFg
    font {
        family: Config.fontFamily
        pixelSize: Config.fontSize
        bold: true
    }

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
