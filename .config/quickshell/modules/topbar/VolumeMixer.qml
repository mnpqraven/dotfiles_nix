import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs.common

// TODO: not working, idk why
ColumnLayout {
    required property PwNode node

    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [node]
    }

    RowLayout {
        Image {
            visible: source !== ""
            source: {
                const icon = node?.properties["application.icon-name"] ?? "audio-volume-high-symbolic";
                return `image://icon/${icon}`;
            }

            sourceSize.width: 20
            sourceSize.height: 20
        }

        StyledText {
            text: {
                // application.name -> description -> name
                const app = node?.properties["application.name"] ?? (node?.description != "" ? node?.description : node?.name);
                const media = node.properties["media.name"];
                return media != undefined ? `${app} - ${media}` : app;
            }
        }

        Button {
            text: node.audio?.muted ? "unmute" : "mute"
            onClicked: node.audio.muted = !node.audio.muted
        }
    }

    RowLayout {
        StyledText {
            Layout.preferredWidth: 50
            text: `${Math.floor(node?.audio.volume * 100)}%`
        }

        Slider {
            Layout.fillWidth: true
            value: node.audio.volume
            onValueChanged: node.audio.volume = value
        }
    }
}
