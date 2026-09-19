import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs.common

ColumnLayout {
    id: root
    required property PwNode node

    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [root.node]
    }

    ColumnLayout {
        RowLayout {
            StyledText {
                text: {
                    // application.name -> description -> name
                    const app = root.node?.properties["application.name"] ?? (root.node?.description != "" ? root.node?.description : root.node?.name) ?? '';
                    const media = root.node?.properties["media.name"] ?? '';
                    return media ? app : `${app} - ${media}`;
                }
            }
        }

        RowLayout {
            StyledText {
                Layout.preferredWidth: 50
                text: `${Math.floor(root.node?.audio.volume * 100)}%`
            }

            Slider {
                Layout.fillWidth: true
                value: root.node?.audio.volume
                onValueChanged: root.node.audio.volume = value
            }
            Button {
                text: root.node?.audio.muted ? "unmute" : "mute"
                onClicked: root.node.audio.muted = !root.node?.audio.muted
            }
        }
    }

    Repeater {
        model: Pipewire.nodes.values.filter(e => e.isStream)

        ColumnLayout {
            id: c
            property PwNode node: modelData
            PwObjectTracker {
                objects: [modelData]
            }

            RowLayout {
                StyledText {
                    text: c.node.properties["media.name"] ?? ''
                }
            }

            RowLayout {
                StyledText {
                    Layout.preferredWidth: 50
                    text: `${Math.floor(c.node?.audio.volume * 100)}%`
                }
                Slider {
                    Layout.fillWidth: true
                    value: c.node.audio.volume
                    onValueChanged: c.node.audio.volume = value
                }

                Button {
                    text: c.node?.audio.muted ? "unmute" : "mute"
                    onClicked: c.node.audio.muted = !c.node?.audio.muted
                }
            }
        }
    }
}
