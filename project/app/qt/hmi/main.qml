import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.5

import Style 1.0

ApplicationWindow {
    width: Style.screen.width
    height: Style.screen.height
    visible: true
    title: qsTr("QT HMI")


    Loader {
        id: loader_main
        width: Style.screen.width; height: Style.screen.height
        asynchronous: true
        active: true
        state: "visible"
        visible: true
        source: "qrc:/UI/Home.qml"
    }
}
