pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string status: ''

    Process {
        id: cfProc
        command: ["sh", "-c", "warp-cli status"]
        stdout: StdioCollector {
            onStreamFinished: () => {
                // example output
                // ```
                // Status update: Connecting
                // Reason: Establishing connection to 162.159.198.2:443
                // ```
                const findStatus = this.text.trim().split(/\n/)[0].split(/\:/)[1].trim();
                root.status = findStatus;
            }
        }
    }

    function refetch() {
        timer.restart();
    }

    Timer {
        id: timer
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: cfProc.running = true
    }
}
