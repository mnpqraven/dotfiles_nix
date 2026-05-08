import Quickshell
import QtQuick
import qs.common

StyledText {
    text: ''
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => Quickshell.execDetached(["sh", "-c", "$DEFAULT_TERMINAL"])
    }
}
