import QtQuick
import QtQuick.Layouts
import qs.modules.topbar
import qs.common

// vertical left bar
ColumnLayout {
    required property Item squareAnchor

    Layout.alignment: Qt.AlignTop

    anchors {
        top: squareAnchor.bottom
        bottom: parent.bottom
        horizontalCenter: squareAnchor.horizontalCenter
        bottomMargin: Config.spacing.gapItem * 2
    }

    Rectangle {
        Layout.fillHeight: true
    }

    Power {}
}
