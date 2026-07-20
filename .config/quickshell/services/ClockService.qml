pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    // direct access object
    property SystemClock clock: clock

    readonly property string dateTime: Qt.formatDateTime(clock.date, "ddd dd MMM yyyy - hh:mm A")
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm A")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
