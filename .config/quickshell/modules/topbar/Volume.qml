import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import qs.common
import qs.services

StyledText {
    id: root

    text: "  " + Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) + "%"
    color: Pipewire.defaultAudioSink?.audio.muted ? Config.colMuted : Config.colFg

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onWheel: wheel => {
            // scroll up
            if (wheel.angleDelta.y > 0)
                Pipewire.defaultAudioSink.audio.volume += 0.05;
            else
                Pipewire.defaultAudioSink.audio.volume -= 0.05;
        }
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function (ev) {
            // TODO: mixer dialog on left click
            if (ev.button === Qt.RightButton) {
                const audio = Pipewire.defaultAudioSink.audio;
                audio.muted = !audio.muted;
            } else {
                mixerPopover.toggle();
            }
        }
    }

    UnmaskedPopover {
        id: mixerPopover
        anchorItem: root

        CardContainer {
            opacity: mixerPopover.opacity
            ColumnLayout {
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY

                Button {
                    text: 'Settings'
                    onClicked: () => {
                        Quickshell.execDetached(["sh", "-c", "easyeffects"]);
                        PopoverService.closeAll();
                    }
                }

                VolumeMixer {
                    node: Pipewire.defaultAudioSink
                }
            }
        }
    }
}
