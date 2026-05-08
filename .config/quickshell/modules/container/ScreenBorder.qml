pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Effects
import qs.common

// drop shadow wrapper
// @see https://github.com/caelestia-dots/shell/blob/rapidfuzz/modules/drawers/Drawers.qml#L85-L104
Item {
    id: omegaroot
    required property ShellScreen screen
    required property bool isVertical

    anchors.fill: parent

    // border inset shadow
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        blurMax: 15
        shadowColor: Qt.rgba(0, 0, 0, 0.5)
    }

    // drawing borders
    // @see https://github.com/caelestia-dots/shell/blob/rapidfuzz/modules/drawers/Border.qml
    Item {
        id: root

        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: Config.colBg

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
            // this is important, do not remove
            visible: false

            // this is the inner rect
            // setting radius here for the inset effect
            Rectangle {
                anchors.fill: parent
                anchors.margins: Config.spacing.gapItem

                anchors.topMargin: Config.spacing.barHeight
                // TODO: vertical monitors should not support this
                anchors.leftMargin: omegaroot.isVertical ? Config.spacing.gapItem : Config.spacing.barHeight

                radius: Config.spacing.barRadius
            }
        }
    }
}
