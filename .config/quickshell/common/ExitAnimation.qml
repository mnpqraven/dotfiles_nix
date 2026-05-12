import QtQuick
import qs.common

Item {
    property bool internalVisible
    // have to declare property to make this OR reactive
    property bool isAnimationRunning: mountAnimation.running
    property bool shouldShow: internalVisible || isAnimationRunning

    opacity: internalVisible ? 1 : 0

    // this should be the same as visible but changes {duration} after `visible` becomes false
    // same behaviour when `shouldShow` becomes true
    Timer {
        id: mountAnimation
        interval: Config.animation.opacityDuration
        repeat: false
    }

    function setVisible(visible: bool) {
        internalVisible = visible;
    }

    onInternalVisibleChanged: () => mountAnimation.restart()

    Behavior on opacity {
        NumberAnimation {
            duration: Config.animation.opacityDuration
            easing.type: Easing.OutCubic
        }
    }
}
