import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.common

StyledText {
    id: root

    // hooking up with pipewire
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    Connections {
        target: Pipewire.defaultAudioSink?.audio
    }

    text: "VOL: " + Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) + "%"
    color: Pipewire.defaultAudioSink?.audio.muted ? Config.colMuted : Config.colFg

    MouseArea {
        anchors.fill: parent
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

    // get a list of nodes that output to the default sink
    PwNodeLinkTracker {
        id: linkTracker
        node: Pipewire.defaultAudioSink
    }

    UnmaskedPopover {
        id: mixerPopover
        anchorItem: root

        CardContainer {
            ColumnLayout {
                x: Config.spacing.marginGutterX
                y: Config.spacing.marginGutterY

                VolumeMixer {
                    node: Pipewire.defaultAudioSink
                }

                Repeater {
                    model: linkTracker.linkGroups

                    VolumeMixer {
                        required property PwLinkGroup modelData
                        // Each link group contains a source and a target.
                        // Since the target is the default sink, we want the source.
                        node: modelData.source
                    }
                }
            }
        }
    }
}
