pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io
import "./TConfigReaderService"

Singleton {
    id: root

    readonly property alias browser: features.browser
    readonly property alias gaming: features.gaming
    readonly property alias kde: features.kde
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
            property BrowserConfig browser: BrowserConfig {}
            property ToggleConfig gaming: ToggleConfig {}
            property KdeConfig kde: KdeConfig {}
            property ToolsConfig tools: ToolsConfig {}
            property ServicesConfig services: ServicesConfig {}
        }
    }
}
