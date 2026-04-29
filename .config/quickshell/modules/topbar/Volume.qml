import QtQuick
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

        function onVolumeChanged() {
        // console.log('onVolumeChanged', Pipewire.defaultAudioSink?.audio.volume);
        }
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
        onClicked: ev => {
            const audio = Pipewire.defaultAudioSink.audio;
            audio.muted = !audio.muted;
        }
    }
}
