import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0

import Style 1.0

Item {

    property string strNotifImgSource: ""
    property string strNotifText: ""

    Rectangle {
        id: rectHeader
        width: parent.width; height: 40
        anchors {top: parent.top; horizontalCenter: parent.horizontalCenter}
        color: "#D5D5D5"

        Label {
            id: lblSetting
            text: "Home"
            anchors {centerIn: parent}
            font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 18 }
            color: Style.color.black
        }
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10


        RowLayout {
            spacing: 10

            Rectangle{
                width: dialVolume.width; height: dialVolume.height

                Dial {
                    id: dialVolume
                    width: 120; height: width
                    from: 0; to: 30
                    value: 0
                    stepSize: 1
                }

                Label {
                    id: lblVolume
                    text: qsTr("VOL: %1").arg(dialVolume.value)
                    anchors {centerIn: parent}
                    font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 12 }
                    color: Style.color.black
                }
            } // rectangle

            Rectangle{
                width: dialAdc1.width; height: dialAdc1.height

                Dial {
                    width: 120; height: width
                    id: dialAdc1
                    from: 0; to: 4095
                    value: 0
                    stepSize: 1
                }

                Label {
                    id: lblAdc1
                    text: qsTr("ADC1: %1").arg(dialAdc1.value)
                    anchors {centerIn: parent}
                    font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 12 }
                    color: Style.color.black
                }
            } // rectangle

            Rectangle{
                width: dialAdc2.width; height: dialAdc2.height

                Dial {
                    width: 120; height: width
                    id: dialAdc2
                    from: 0; to: 4095
                    value: 0
                    stepSize: 1
                }

                Label {
                    id: lblAdc2
                    text: qsTr("ADC2: %1").arg(dialAdc2.value)
                    anchors {centerIn: parent}
                    font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 12 }
                    color: Style.color.black
                }
            } // rectangle
        } //row layout

        ColumnLayout {
            spacing: 10

            RoundButton {
                text: "Touch Me"
                radius: 8
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                Layout.preferredWidth: 150
                Layout.preferredHeight: 50
                font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 15 }
                onClicked: {
                    popupNotif.open()
                    strNotifImgSource = "qrc:/assets/icon/baseline_info_white_36dp.png"
                    strNotifText = "AH yess.."
                }
            }

            RoundButton {
                text: "Dont Touch Me"
                radius: 8
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                Layout.preferredWidth: 150
                Layout.preferredHeight: 50
                font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 15 }

                onClicked: {
                    popupNotif.open()
                    strNotifImgSource = "qrc:/assets/icon/baseline_info_white_36dp.png"
                    strNotifText = "Oh noo.."
                }
            }

            Switch {
                text:  "Test"
            }
        }

    }

    Popup {
            id: popupNotif
            modal: true
            focus: true
            clip: true
            width: parent.width-200; height: parent.height-200
            anchors.centerIn: parent
            closePolicy: Popup.NoAutoClose

            background: Rectangle {
                anchors.fill: parent
                color: Style.color.highlight1
                radius: 8
            }

            Image {
                id: imgNotif
                x: 4;
                width: 100;
                height: width
                source: strNotifImgSource
                anchors { centerIn: parent; verticalCenterOffset: -60}
            }

            Text {
                id: txtNotif
                color: Style.color.white
                text: strNotifText
                width: 280
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors { top: imgNotif.bottom; topMargin: 40; horizontalCenter: parent.horizontalCenter }
                font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 20 }
            }

            Timer {
                id: tmrNotif
                interval: 2000
                repeat: false
                running: popupNotif.visible
                onTriggered: {
                    popupNotif.close();
                }
            }
        }



    Connections {
        target: device

        function onAuxDataTriggered( data ) {
            //console.log("Volume: " + data["volume"]);
            dialVolume.value = data["volume"];
            dialAdc1.value = data["adc1"];
            //console.debug("adc1: " + dialAdc1.value);
        }
    }
}
