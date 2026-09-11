pragma Singleton

import Quickshell
import Quickshell.Io
import qs.services

// INFO: https://quickshell.org/docs/v0.1.0/types/Quickshell.Io/IpcHandler/
Singleton {
    id: root

    // key = target, value id object
    property var ipcObjectDict: ({})

    function setId(screen: string, objectId) {
        ipcObjectDict[screen] = objectId;
    }

    // focused screen info from niri-qml
    function getFocusedScreenName(): string {
        const focused = Niri.focusedWindow;
        if (!focused)
            return '';

        for (let i = 0; i < Niri.workspaces.count; i++) {
            const ws = Niri.workspaces.get(i);
            if (ws.id === focused.workspaceId)
                return ws.output;
        }
        return '';
    }

    // objectId
    function getFocusedObjectId() {
        const screenName = root.getFocusedScreenName();
        return root.ipcObjectDict[screenName];
    }

    IpcHandler {
        target: "control_panel"

        function state(): real {
            const popover = root.getFocusedObjectId();
            return popover.opacity;
        }
        function toggle(): void {
            const popover = root.getFocusedObjectId();
            popover.toggle();
        }
    }
}
