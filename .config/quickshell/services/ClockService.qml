pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string dateTime: Qt.formatDateTime(clock.date, "dd/MM/yyyy - hh:mm A")
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm A")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
