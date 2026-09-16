pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string status
    property var details

    Process {
        id: proc
        command: ["sh", "-c", "mullvad status -j"]
        stdout: StdioCollector {
            onStreamFinished: () => {
                const jsoned = JSON.parse(this.text);
                root.status = jsoned.state;
                root.details = jsoned.details;
            }
        }
    }

    function start() {
        timer.start();
    }

    function stop() {
        timer.stop();
    }

    function refetch() {
        timer.restart();
    }

    function toggle() {
        if (root.status.toLowerCase() === 'connected')
            root.disconnect();
        else
            root.connect();
    }

    function connect() {
        Quickshell.execDetached(["sh", "-c", "mullvad connect"]);
    }

    function disconnect() {
        Quickshell.execDetached(["sh", "-c", "mullvad disconnect"]);
    }

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }
}
