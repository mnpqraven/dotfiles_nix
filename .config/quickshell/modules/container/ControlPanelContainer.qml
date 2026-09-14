import QtQuick
import QtQuick.Layouts
import qs.modules.panel
import qs.common

UnmaskedPopover {
    id: popover
    side: 'right'

    CardContainer {
        opacity: popover.opacity

        ColumnLayout {
            x: Config.spacing.marginGutterX
            y: Config.spacing.marginGutterY

            Switcher {
                opacity: popover.opacity
            }
            IconTray {}
            Calendar {
                Layout.fillWidth: true
            }
        }
    }
}
