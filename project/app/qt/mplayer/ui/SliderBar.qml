import QtQuick 2.0
// import QtMultimedia 5.0

Image {
    id: barSlider

    //property alias audioPlayer: mediaPlayer
    property url bgImg
    property url bufferImg: "qrc:/gfx/slider_value_left.png"
    property url progressImg: "qrc:/gfx/slider_value_right.png"
    property url knobImg

    width: parent.width
    source: bgImg
    anchors.verticalCenterOffset: 3

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (mediaPlayer.seekable)
                mediaPlayer.seek(mediaPlayer.duration * mouse.x/width);
        }
    }

    Rectangle {
        width: parent.width - 4
        anchors.verticalCenterOffset: -1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: 16
        color: "transparent"
        BorderImage {
            id: trackBuffer
            width:  mediaPlayer.bufferProgress ? mediaPlayer.bufferProgress*parent.width : 0
            source: bufferImg
            border { left: 8; top: 8; right: 8; bottom: 8 }
            horizontalTileMode: BorderImage.Stretch
            verticalTileMode: BorderImage.Stretch
        }
    }

    Rectangle {
        width: parent.width - 4
        anchors.verticalCenterOffset: -1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: 16
        color: "transparent"
        BorderImage {
            id: trackProgress
            source: progressImg
            width: mediaPlayer.duration>0?parent.width*mediaPlayer.position/mediaPlayer.duration:0
            border { left: 8; top: 8; right: 8; bottom: 8 }
            horizontalTileMode: BorderImage.Stretch
            verticalTileMode: BorderImage.Stretch
        }
    }

    Rectangle {
        width: parent.width - 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        Image {
            id: trackSeeker
            source: knobImg
            anchors.verticalCenter: parent.verticalCenter
            x: trackProgress.width - 10
            state: "none"
            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: parent
                drag.axis: Drag.XAxis
                drag.minimumX: -10
                drag.maximumX: parent.parent.width-20
                onPressed: trackSeeker.state = "pressed"
                onReleased: {
                    trackSeeker.state = "none"
                    if (mediaPlayer.seekable)
                        mediaPlayer.seek(mediaPlayer.duration * trackSeeker.x/(parent.parent.width-10));
                }
            }
            states: State {
                name: "pressed"
                when: dragArea.pressed
                PropertyChanges { target: trackSeeker; scale: 1.2 }
            }
            transitions: Transition {
                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
            }
        }
    }
}
