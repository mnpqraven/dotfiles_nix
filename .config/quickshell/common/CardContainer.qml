import QtQuick.Effects
import QtQuick
import qs.common

Rectangle {
    id: container

    // dynamically from children
    width: childrenRect.width + (Config.spacing.marginGutterX * 2)
    height: childrenRect.height + (Config.spacing.marginGutterY * 2)

    radius: Config.spacing.barRadius
    color: Config.colBg

    border.color: Qt.lighter(Qt.color(Config.colFg), 0.5)
    border.width: 1

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Qt.rgba(0, 0, 0, 0.5)
        shadowBlur: 0.4
    }
}
