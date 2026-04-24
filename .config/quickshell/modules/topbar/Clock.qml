pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root
    property string time

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: root.time = root.getDate()
    }

    function getDate() {
        return Qt.formatDateTime(new Date(), "dd/MM/yyyy - HH:mm");
    }
}
