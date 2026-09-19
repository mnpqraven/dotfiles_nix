pragma Singleton

import Quickshell
import Quickshell.Io
import qs.services

// INFO: https://quickshell.org/docs/v0.1.0/types/Quickshell.Io/IpcHandler/
Singleton {
    id: root

    // key = target, value is js object
    // {
    //   controlPanelId
    //   volumeMixerId
    // }
    property var ipcObjectDict: ({})

    function setControlPanelId(screen: string, objectId) {
        if (!ipcObjectDict[screen])
            ipcObjectDict[screen] = {};
        ipcObjectDict[screen].controlPanelId = objectId;
    }
    function setVolumeMixerId(screen: string, objectId) {
        if (!ipcObjectDict[screen])
            ipcObjectDict[screen] = {};
        ipcObjectDict[screen].volumeMixerId = objectId;
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
            const popover = root.getFocusedObjectId().controlPanelId;
            return popover.opacity;
        }
        function toggle(): void {
            const popover = root.getFocusedObjectId().controlPanelId;
            popover.toggle();
        }
    }
    IpcHandler {
        target: "all_panel"

        function toggle(): void {
            // temp. fix, close after a full toggle loop (volume > control > closeAll)
            if (root.getFocusedObjectId().controlPanelId.opacity) {
                root.getFocusedObjectId().controlPanelId.toggle();
                return;
            }
            // BUG: this is correct but the popover singleton is only accepting 1 open popevr at a time
            root.getFocusedObjectId().controlPanelId.toggle();
            root.getFocusedObjectId().volumeMixerId.toggle();
            return;
        }
    }
}
