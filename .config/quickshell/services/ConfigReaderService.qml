pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    id: root

    readonly property alias browser: features.browser
    readonly property alias gaming: features.gaming
    readonly property alias services: features.services
    readonly property alias tools: features.tools

    FileView {
        id: fileview
        // TODO: dyn
        path: "/home/othi/.config/features-conf/config.json"
        // when changes are made on disk, reload the file's content
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: features
            property JsonObject browser: JsonObject {
                property JsonObject helium: JsonObject {
                    property bool enabled: false
                }
                property JsonObject zen: JsonObject {
                    property bool enabled: false
                }
                property JsonObject librewolf: JsonObject {
                    property bool enabled: false
                }
            }
            property JsonObject gaming: JsonObject {
                property bool enable: false
            }
            property JsonObject tools: JsonObject {
                property JsonObject obs: JsonObject {
                    property bool enable: false
                }
                property JsonObject discord: JsonObject {
                    property bool enable: false
                } property JsonObject torrent: JsonObject {
                    property bool enable: false
                }
            }
            property JsonObject services: JsonObject {
                property JsonObject syncthing: JsonObject {
                    property bool enable: false
                }
            }
        }
    }
}
