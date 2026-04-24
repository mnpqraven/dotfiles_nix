import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
    id: cpu
    property int lastCpuTotal: 0
    property int lastCpuIdle: 0
    property int usage: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (cpu.lastCpuTotal > 0) {
                    usage = Math.round(100 * (1 - (idle - cpu.lastCpuIdle) / (total - cpu.lastCpuTotal)));
                }
                cpu.lastCpuTotal = total;
                cpu.lastCpuIdle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        // TODO: lift up
        onTriggered: {
            cpuProc.running = true;
            // memProc.running = true;
        }
    }

    Text {
        text: `CPU: ${cpu.usage} %`
        color: "yellow"
    }
}
