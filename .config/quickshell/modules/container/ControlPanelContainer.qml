import QtQuick
import QtQuick.Layouts
import qs.modules.panel
import qs.common
import qs.services

UnmaskedPopover {
    id: popover
    side: 'right'

    CardContainer {
        opacity: popover.opacity
        property bool open: popover.opacity !== 0

        onOpenChanged: {
            if (open)
                MullvadService.start();
            else
                MullvadService.stop();
        }

        ColumnLayout {
            x: Config.spacing.marginGutterX
            y: Config.spacing.marginGutterY

            Switcher {}
            IconTray {}
            Calendar {
                Layout.fillWidth: true
            }
        }
    }
}
