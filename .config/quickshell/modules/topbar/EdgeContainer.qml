pragma ComponentBehavior: Bound

import Quickshell.Services.UPower
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.modules.topbar
import qs.common
import qs.services

PanelWindow {
    id: container

    required property ShellScreen modelData

    screen: modelData

    anchors.top: true
    anchors.left: true
    anchors.right: true
    anchors.bottom: true

    // WlrLayershell.exclusionMode: ExclusionMode.Ignore

    color: 'transparent'

    // DEV: allow mouse passthrough
    // TODO: omit or program this correctly
    mask: Region {}

    // @see https://github.com/caelestia-dots/shell/blob/rapidfuzz/modules/drawers/Drawers.qml#L85-L104
    Item {
        anchors.fill: parent
        // opacity: Colours.transparency.enabled ? Colours.transparency.base : 1

        // border inset shadow
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            blurMax: 15
            shadowColor: 'red'
        }

        // @see https://github.com/caelestia-dots/shell/blob/rapidfuzz/modules/drawers/Border.qml
        // TODO: file refactor
        Item {
            id: root

            // required property Item bar

            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                color: Config.colFg

                layer.enabled: true
                layer.effect: MultiEffect {
                    maskSource: mask
                    maskEnabled: true
                    maskInverted: true
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1
                }
            }

            Item {
                id: mask

                anchors.fill: parent
                layer.enabled: true
                visible: false

                // this is the inner rect
                // setting radius here for the inset effect
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: Config.spacing.gapItem

                    anchors.topMargin: Config.spacing.barHeight
                    // TODO: vertical monitors should not support this
                    anchors.leftMargin: Config.spacing.barHeight

                    radius: Config.spacing.barRadius
                }
            }
        }
    }
}
