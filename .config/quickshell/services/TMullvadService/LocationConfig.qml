import QtQuick

QtObject {
    property string ipv4: ''
    property string ipv6: ''
    property string country: ''
    property string city: ''
    property real latitude
    property real longitude
    property bool mullvad_exit_ip: true
    property string hostname: ''
    property string entry_hostname: ''
}
