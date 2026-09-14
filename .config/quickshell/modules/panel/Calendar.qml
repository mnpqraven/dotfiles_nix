pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.common
import qs.services

Item {
    id: root

    implicitHeight: childrenRect.height

    ColumnLayout {
        // TODO: fancy box
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
                        color: root.colorFgHeader(headerCell.modelData)
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
                    color: root.colorBgCell(modelData)

                    StyledText {
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
        // monday = 0, sunday = 6
        const firstInMonthWeekday = (firstInMonth.getDay() + 6) % 7;

        return new Date(firstInMonth.getFullYear(), firstInMonth.getMonth(), 1 - firstInMonthWeekday);
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

    function isSameMonth(index: real): bool {
        const now = ClockService.clock.date;
        const then = getIndexedDate(index);
        return now.getFullYear() === then.getFullYear() && now.getMonth() === then.getMonth();
    }

    function weekDayFromIndex(index: real): string {
        // monday = 0, sunday = 6
        switch (index) {
        case 0:
            return 'Mon';
        case 1:
            return 'Tue';
        case 2:
            return 'Wed';
        case 3:
            return 'Thu';
        case 4:
            return 'Fri';
        case 5:
            return 'Sat';
        case 6:
            return 'Sun';
        }
    }

    function colorBgCell(modelData: real): color {
        if (!root.isSameMonth(modelData))
            return Config.colBg;
        else if (root.isToday(modelData))
            return Config.colDarkBlue;
        else
            return Config.colMuted;
    }

    function colorFgHeader(modelData: real): color {
        if (modelData == 5 || modelData == 6)
            return Config.colYellow;
        return Config.colFg;
    }

    function colorFg() {
    }
}
