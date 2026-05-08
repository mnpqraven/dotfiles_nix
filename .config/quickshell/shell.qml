//@ pragma DefaultEnv QS_NO_RELOAD_POPUP=1

import Quickshell
import QtQuick
import qs.common
import "modules/container"
import "modules/osd"

// FIXME: layer-rule in niri
// @see laptop.kdl@268

/**
* ref docs
* https://quickshell.org/docs/v0.2.1/types/Quickshell.Io/Process/?highlight=process
* https://quickshell.org/docs/v0.2.1/guide/introduction/#reusable-components
* https://github.com/quickshell-mirror/quickshell/issues/47
* https://www.tonybtw.com/tutorial/quickshell/#03-workspaces
*/
ShellRoot {
    // top bars
    // Variants {
    //     model: Quickshell.screens
    //     // TODO: lift timer and processes
    //     delegate: Bar {}
    // }

    // expr
    Variants {
        model: Quickshell.screens
        // TODO: lift timer and processes
        delegate: EdgeContainer {}
    }

    // other singletons like OSDs, listeners
    PipewireOsd {}
}
