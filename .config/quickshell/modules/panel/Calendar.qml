pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.services

Item {
    id: root

    implicitHeight: childrenRect.height

    ColumnLayout {
        StyledText {
            text: ClockService.dateTime
        }

        anchors.left: parent.left
        anchors.right: parent.right

        // header
        GridLayout {
            columns: 7
            uniformCellWidths: true

            Repeater {
                id: headerRow
                model: 7

                Rectangle {
                    id: headerCell
                    required property real modelData

                    Layout.preferredHeight: childrenRect.height
                    Layout.fillWidth: true
                    color: 'transparent'

                    StyledText {
                        text: root.weekDayFromIndex(headerCell.modelData)
                        anchors.centerIn: parent
                    }
                }
            }
        }

        GridLayout {
            id: layout
            columns: 7
            uniformCellWidths: true
            uniformCellHeights: true

            Repeater {
                id: weekRows
                // TODO: row count is still hardcoded
                model: 7 * 6 // 6 weeks

                Rectangle {
                    id: cell
                    required property real modelData

                    Layout.preferredHeight: 40
                    Layout.fillWidth: true
                    radius: Config.spacing.barRadius

                    // TODO: hover state
                    color: root.isToday(modelData) ? Config.colBlue : Config.colMuted

                    StyledText {
                        // TODO: date display
                        text: root.getIndexedDate(cell.modelData).getDate()
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

    // if the first day of the month is a monday
    // if this returns true, then the calendar can only have 4 or 5 rows
    // if this is false then the calendar can have between 5 to 7 rows
    function segmentedStart(): bool {
        const clock = ClockService.clock.date;
        const firstDayInMonth = new Date(clock.getFullYear(), clock.getMonth(), 1);

        return firstDayInMonth.getDay() !== 1;
    }

    // if the first day of the month is a sunday
    function segmentedEnd(): bool {
        const clock = ClockService.clock.date;
        const lastDayInMonth = new Date(clock.getFullYear(), clock.getMonth() + 1, 0);

        return lastDayInMonth.getDay() !== 0;
    }

    // calculates the first day in the table
    // following date can be calculated with offset (`new Date(first.year, first.month, first.day + index)`)
    function firstCellDate(): date {
        const now = ClockService.clock.date;
        const firstInMonth = new Date(now.getFullYear(), now.getMonth(), 1);
        // sunday = 0, monday = 1
        const firstInMonthWeekday = firstInMonth.getDay();

        if (firstInMonthWeekday === 1)
            return firstInMonth;

        if (firstInMonthWeekday === 0)
            return new Date(firstInMonth.getFullYear(), firstInMonth.getMonth(), -6);

        // tuesday's value is 2 but we only subtract 1, etc...
        const next = new Date(firstInMonth.getFullYear(), firstInMonth.getMonth(), -firstInMonthWeekday);
        return next;
    }

    function getIndexedDate(index: real): date {
        const firstCell = firstCellDate();
        const nextDate = new Date(firstCell.getFullYear(), firstCell.getMonth(), firstCell.getDate() + index);
        return nextDate;
    }

    function isToday(index: real): bool {
        const now = ClockService.clock.date;
        const then = getIndexedDate(index);
        return now.getFullYear() === then.getFullYear() && now.getMonth() === then.getMonth() && now.getDate() === then.getDate();
    }
    function weekDayFromIndex(index: real): string {
        // sunday = 0, monday = 1
        switch (index) {
        case 0:
            return 'Sun';
        case 1:
            return 'Mon';
        case 2:
            return 'Tue';
        case 3:
            return 'Wed';
        case 4:
            return 'Thu';
        case 5:
            return 'Fri';
        case 6:
            return 'Sat';
        }
    }
}
