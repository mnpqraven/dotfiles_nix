pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.modules.topbar
import qs.common

// this component handles:
// - drawing outer borders
// - inset border radius
// - inset drop shadow
PanelWindow {
    id: container

    required property ShellScreen modelData

    property bool isVertical: screen.height > screen.width

    screen: modelData

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true

    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    color: 'transparent'

    // allow mouse passthrough
    mask: Region {
        x: Config.spacing.barHeight + Config.spacing.gapItem
        y: Config.spacing.barHeight + Config.spacing.gapItem
        width: container.width - Config.spacing.barHeight - (Config.spacing.gapItem * 2)
        height: container.height - Config.spacing.barHeight - (Config.spacing.gapItem * 2)
        intersection: Intersection.Xor
    }

    ScreenBorder {
        isVertical: container.isVertical
        screen: container.modelData
    }

    // top left square, should just be a terminal button with padding to make a square
    // this will act as a centering anchor for horizontal and vertical bars
    Rectangle {
        id: topleft
        implicitHeight: Config.spacing.barHeight
        implicitWidth: Config.spacing.barHeight
        color: 'transparent'

        TerminalButton {
            anchors.centerIn: parent
        }
    }

    HorizontalBar {
        squareAnchor: topleft
    }

    // only normal monitors, vertical monitors doesn't have this
    Loader {
        id: loader
        active: !container.isVertical
        sourceComponent: VerticalBar {
            parent: loader.parent
            squareAnchor: topleft
        }
    }
}
