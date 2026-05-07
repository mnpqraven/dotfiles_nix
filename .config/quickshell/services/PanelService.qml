pragma Singleton
import Quickshell

// Dictionary for panel/popovers

Singleton {
    // TODO: ts
    property var barDict: ({}) // key is screenName, value bar

    function setBar(screen: string, barId) {
        barDict[screen] = barId;
    }
}
