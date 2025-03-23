import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0

ApplicationWindow {
    width: 480
    height: 480
    visible: true
    color: "black"

    Component.onCompleted: {
        console.info("Component on completed")
        loader_main.setSource("qrc:/ui/MusicPlayer.qml")
    }

    // main container
    Loader {
        id: loader_main
        asynchronous: true
        width: parent.width; height: parent.height
        x: 0; y: 0
        active: true
        state: "visible"
        visible: true
    }

}
