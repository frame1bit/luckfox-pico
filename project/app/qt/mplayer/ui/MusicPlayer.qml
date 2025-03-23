import QtQuick 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.12
import Qt.labs.folderlistmodel 2.1
//import QtQuick.Extras 1.4

Image {
    id: background
    source: "qrc:/gfx/background.png"

    // MediaPlayer {
    //     id: player
    // }

    Item {
        id: playLogic

        property int index: -1
        //property alias mediaPlayer: mediaPlayer
        property FolderListModel items: FolderListModel {
            folder: "music"
            nameFilters: ["*.mp3"]
        }
        property var lMusic: ["Ada apa denganku", "Meraih Mimpi", "Kau Selalu Dihati"];

        ListModel {
            id: listMusic

            ListElement {
                title: "Ada apa denganku"
                duration: 4
            }
            ListElement {
                title: "Meraih mimpi"
                duration: 6
            }
            ListElement {
                name: "Kau Selalu di hatiku"
                duration: 3
            }

        }

        function init(){
            if(mediaPlayer.playbackState===1){
                mediaPlayer.pause();
            }else if(mediaPlayer.playbackState===2){
                mediaPlayer.play();
            }else{
                setIndex(1);
            }
        }

        function setIndex(i)
        {
            index = i;

            if (index < 0 || index >= listMusic.count)
            {
                index = -1;
                mediaPlayer.source = "";
            }
            else{
                mediaPlayer.source = listMusic.get(0).name
                mediaPlayer.play();
            }
        }

        function next(){
            setIndex(index + 1);
        }

        function previous(){
            setIndex(index - 1);
        }

        function msToTime(duration) {
            var seconds = parseInt((duration/1000)%60);
            var minutes = parseInt((duration/(1000*60))%60);

            minutes = (minutes < 10) ? "0" + minutes : minutes;
            seconds = (seconds < 10) ? "0" + seconds : seconds;

            return minutes + ":" + seconds;
        }

        Connections {
            target: mediaPlayer

            function onPaused() {
                playPause.source = "qrc:/icons/play.png";
            }

            function onPlaying() {
                playPause.source = "qrc:/icons/pause.png";
            }

            function onStopped() {
                playPause.source = "qrc:/icons/play.png";
                if (mediaPlayer.status === MediaPlayer.EndOfMedia)
                    playLogic.next();
            }

            function onError() {
                console.log(error+" error string is "+errorString);
            }

            function onMediaObjectChanged() {
                if (mediaPlayer.mediaObject)
                    playLogic.mediaPlayer.mediaObject.notifyInterval = 50;
            }
        }
    } // Item

    FontLoader {
        id: appFont
        //name: "OpenSans-Regular"
        source: "qrc:/fonts/OpenSans-Regular.ttf"
    }

    Rectangle{
        id: rectUpper
        width: parent.width; height: 320 - foreground.height
        anchors {top: parent.top}
        //opacity: 0.2
        gradient: Gradient {
            GradientStop { position: 0.0; color: "gray" }
            GradientStop { position: 0.5; color: "black" }
            orientation: Gradient.Horizontal
        }
        color: "black"

        Rectangle {
            id: rectImgArt
            anchors {top: parent.top; topMargin: 10; left: parent.left; leftMargin: 10}
            width: imgArt.width + 20; height: imgArt.height + 20
            border.color: "yellow"
            border.width: 4
            radius: 5

            Image {
                id: imgArt
                width: 140; height: width + 20
                fillMode: Image.PreserveAspectFit
                source: "qrc:/gfx/art.png"
                anchors.centerIn: parent

            } // images
        }

        ColumnLayout {
            anchors {left: rectImgArt.right; leftMargin: 10; top: parent.top; topMargin: 10}
            Layout.fillWidth: true

            Text {
                id: trackTitle
                text: mediaPlayer.metaData["title"] ? mediaPlayer.metaData["title"] : "Song title unavailable"
                color: "#eeeeee"
                font.family: appFont.name
                font.pointSize: 12
                font.bold: true
                //horizontalAlignment: Qt.AlignCenter
                style: Text.Raised
                styleColor: "#111111"
                wrapMode: Text.Wrap
            }
            Text {
                id: trackAlbum
                text: mediaPlayer.metaData["albumTitle"] ? mediaPlayer.metaData["albumTitle"] : "Song title unavailable"
                color: "steelblue"
                font.family: appFont.name
                font.pointSize: 12
                font.bold: true
                horizontalAlignment: Qt.AlignHCenter
                style: Text.Raised
                styleColor: "#111111"
                wrapMode: Text.Wrap
            }

            Rectangle{width: 300; height: 60; color: "black"; opacity: 0}

            RowLayout {
                spacing: 20

                Rectangle {
                    id: btnEQ
                    border {color: "gray"; width: 3}
                    width: imgEq.width + 20; height: imgEq.height + 20
                    color: "black"
                    radius: 12
                    Image {
                        id: imgEq
                        width: 40; height: width
                        source: "qrc:/icons/outline_equalizer_white_24dp.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        state: "none"
                    }
                    MouseArea {
                        id: mouseAreaEq
                        anchors.fill: parent
                        onPressed: btnEQ.state = "pressed"
                        onReleased: btnEQ.state = "none"
                    }
                    states: State {
                        name: "pressed"
                        when: mouseAreaEq.pressed
                        PropertyChanges { target: btnEQ; scale: 0.8 }
                    }
                    transitions: Transition {
                        NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                    }
                }

                Rectangle {
                    id: btnLyric
                    border {color: "gray"; width: 3}
                    width: imgLyric.width + 20; height: imgLyric.height + 20
                    color: "black"
                    radius: 12
                    Image {
                        id: imgLyric
                        width: 40; height: width
                        source: "qrc:/icons/outline_lyrics_white_24dp.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        state: "none"
                    }

                    MouseArea {
                        id: mouseAreaLyric
                        anchors.fill: parent
                        onPressed: btnLyric.state = "pressed"
                        onReleased: btnLyric.state = "none"
                    }
                    states: State {
                        name: "pressed"
                        when: mouseAreaLyric.pressed
                        PropertyChanges { target: btnLyric; scale: 0.8 }
                    }
                    transitions: Transition {
                        NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                    }
                }

                Rectangle {opacity: 0; width: 50; height: 20}

                Rectangle {
                    id: spotifyIcon
                    border {color: "gray"; width: 3}
                    width: imgLyric.width + 20; height: imgLyric.height + 20
                    color: "black"
                    radius: width/2
                    Image {
                        width: 40; height: width
                        source: "qrc:/gfx/spotify_icon.png"
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        state: "none"
                    }
                }
            }
        }
    }

    Image {
        id: foreground
        source: "qrc:/gfx/bar.png"
        anchors {horizontalCenter: parent.horizontalCenter; bottom: parent.bottom}
        //anchors.verticalCenter: parent.verticalCenter

        ColumnLayout{
            id: container
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: foreground.implicitWidth - 40
            height: foreground.implicitHeight - 30

            RowLayout {
                id: wrapper
                //anchors.fill: parent

                // Rectangle {
                //     id: leftWapper
                //     height: 126
                //     width: 126
                //     radius: 7

                //     BorderImage {
                //         id: coverBorder
                //         source: "gfx/cover_overlay.png"
                //         anchors.fill: parent
                //         anchors.margins: 4
                //         border { left: 10; top: 10; right: 10; bottom: 10 }
                //         horizontalTileMode: BorderImage.Stretch
                //         verticalTileMode: BorderImage.Stretch

                //         Image {
                //             id: coverPic
                //             source: mediaPlayer.metaData.coverArtUrlLarge ? mediaPlayer.metaData.coverArtUrlLarge : "gfx/cover.png"
                //             anchors.fill: coverBorder
                //             anchors.margins: 2
                //         }
                //     }

                // }

                ColumnLayout {
                    id: rightWapper
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 10

                    RowLayout {
                        id: lowerWrap
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        Layout.leftMargin: 5
                        spacing: 15

                        Text {
                            id: currentTime
                            text: playLogic.msToTime(mediaPlayer.position)
                            font.family: appFont.name
                            color: "#dedede"
                            font.pointSize: 12
                        }

                        SliderBar{
                            Layout.fillWidth: true
                            //audioPlayer: player
                            bgImg: "qrc:/gfx/slider_background.png"
                            bufferImg: "qrc:/gfx/slider_value_right.png"
                            progressImg: "qrc:/gfx/slider_value_left.png"
                            knobImg: "qrc:/gfx/slider_knob.png"
                        }

                        Text {
                            id: totalTime
                            text: playLogic.msToTime(mediaPlayer.duration)
                            font.family: appFont.name
                            color: "#dedede"
                            font.pointSize: 12
                        }
                    }

                    RowLayout {
                        id: upperWrap
                        Layout.fillWidth: true
                        Layout.preferredHeight: 100
                        //Layout.leftMargin: 5
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 60

                        Image {
                            id: playMode
                            source: "qrc:/icons/outline_shuffle_white_18dp.png"
                            fillMode: Image.PreserveAspectFit
                            //anchors.verticalCenter: parent.verticalCenter
                            Layout.alignment: Qt.AlignVCenter
                            //anchors.right: parent.right
                            state: "none"

                            MouseArea {
                                id: mouseAreaPlay
                                anchors.fill: parent
                                onPressed: playMode.state = "pressed"
                                onReleased: playMode.state = "none"
                            }
                            states: State {
                                name: "pressed"
                                when: mouseAreaPlay.pressed
                                PropertyChanges { target: playMode; scale: 0.8 }
                            }
                            transitions: Transition {
                                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                            }
                        }

                        Image {
                            id: prevTrack
                            source: "qrc:/icons/rewind.png"
                            //anchors.verticalCenter: parent.verticalCenter
                            Layout.alignment: Qt.AlignVCenter
                            //anchors.leftMargin: 20
                            state: "none"
                            MouseArea {
                                id: mouseAreaPrev
                                anchors.fill: parent
                                onClicked: playLogic.previous()
                                onPressed: prevTrack.state = "pressed"
                                onReleased: prevTrack.state = "none"
                            }
                            states: State {
                                name: "pressed"
                                when: mouseAreaPrev.pressed
                                PropertyChanges { target: prevTrack; scale: 0.8 }
                            }
                            transitions: Transition {
                                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                            }
                        }

                        Rectangle{
                            width: 30
                            //anchors.verticalCenter: parent.verticalCenter
                            Layout.alignment: Qt.AlignVCenter

                            Image {
                                id: playPause
                                source: "qrc:/icons/play.png"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                state: "none"
                                MouseArea {
                                    id: mouseAreaPlayPause
                                    anchors.fill: parent
                                    onClicked: {
                                        playLogic.init();
                                    }
                                    onPressed: playPause.state = "pressed"
                                    onReleased: playPause.state = "none"
                                }
                                states: State {
                                    name: "pressed"
                                    when: mouseAreaPlayPause.pressed
                                    PropertyChanges { target: playPause; scale: 0.8 }
                                }
                                transitions: Transition {
                                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                                }
                            }
                        }

                        Image {
                            id: nextTrack
                            source: "qrc:/icons/forward.png"
                            //anchors.verticalCenter: parent.verticalCenter
                            Layout.alignment: Qt.AlignVCenter
                            state: "none"

                            MouseArea {
                                id: mouseAreaNext
                                anchors.fill: parent
                                onClicked: playLogic.next()
                                onPressed: nextTrack.state = "pressed"
                                onReleased: nextTrack.state = "none"
                            }
                            states: State {
                                name: "pressed"
                                when: mouseAreaNext.pressed
                                PropertyChanges { target: nextTrack; scale: 0.8 }
                            }
                            transitions: Transition {
                                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                            }
                        }


                        Image {
                            id: volume
                            source: "qrc:/icons/outline_volume_up_white_18dp.png"
                            //width: 16; height: width
                            //anchors.verticalCenter: parent.verticalCenter
                            Layout.alignment: Qt.AlignVCenter
                            //anchors.right: parent.right
                            state: "none"

                            MouseArea {
                                id: mouseAreaVol
                                anchors.fill: parent
                                onPressed: {
                                    volume.state = "pressed"
                                    popupVolumex.open();
                                }
                                onReleased: volume.state = "none"
                            }
                            states: State {
                                name: "pressed"
                                when: mouseAreaVol.pressed
                                PropertyChanges { target: volume; scale: 0.8 }
                            }
                            transitions: Transition {
                                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                            }
                        }

                    }// RowLayout
                }// ColumnLayout
            }// RowLayout
        }//ColumnLayout
    } // Image foreground

    Popup {
        id: popupVolumex
        modal: false
        focus: true
        clip: true
        width: 200; height: 150
        anchors.centerIn: parent
        closePolicy: Popup.CloseOnPressOutside

        background: Rectangle {
            anchors.fill: parent
            color: "#D2D7D7"
            radius: 8
            opacity: 1
        }

        // Dial {
        //     id: dialVolume
        //     anchors.centerIn: parent
        // }
    }

    Popup {
        id: popupVolume
        modal: false
        focus: true
        clip: true
        width: 60; height: 160
        x: parent.width - width // Menempatkan popup di sebelah kanan
        y: (20)// Pusatkan vertikal
        closePolicy: Popup.CloseOnPressOutside

        background: Rectangle {
            anchors.fill: parent
            color: "#313247"
            radius: 8
            opacity: 0.8
        }

        Slider {
            id: slider
            Layout.fillWidth: true
            height: 160
            orientation: Qt.Vertical
            rotation: 180
            from: 100; to: 0
            anchors.centerIn: parent
            ToolTip {
                parent: slider.handle
                visible: slider.pressed
                text: slider.value.toFixed(2)
            }
        }
    }
} // Image
