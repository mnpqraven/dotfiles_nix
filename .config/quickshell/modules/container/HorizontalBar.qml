import QtQuick
import QtQuick.Layouts
import qs.modules.topbar
import qs.common
import Quickshell.Services.UPower

RowLayout {
    required property Item squareAnchor
    anchors {
        left: squareAnchor.right
        right: parent.right
        bottom: squareAnchor.bottom
        verticalCenter: squareAnchor.verticalCenter
        rightMargin: Config.spacing.gapItem * 2
    }
    Workspace {}

    WindowTitle {
        Layout.fillWidth: true
    }

    Net {}

    Volume {}

    StyledText {
        text: `CPU: ${CPU.usage}%`
    }

    StyledText {
        text: `MEM: ${Memory.usage}%`
    }

    Separator {}

    Clock {}

    Cloudflare {}

    Loader {
        active: UPower.displayDevice.isLaptopBattery
        sourceComponent: Battery {}
    }
}
