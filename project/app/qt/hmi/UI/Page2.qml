import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import Style 1.0

Rectangle {
    id: container

    Rectangle {
        id: rectHeader
        width: parent.width; height: 40
        anchors {top: parent.top; horizontalCenter: parent.horizontalCenter}
        color: "#D5D5D5"

        Label {
            id: lblSetting
            text: "Auxiliary"
            anchors {centerIn: parent}
            font { family: "Open Sans Regular"; weight: Font.Normal; pixelSize: 18 }
            color: Style.color.black
        }
    }

    RowLayout{
        anchors {centerIn: parent; verticalCenterOffset: 15}

        ColumnLayout {
            spacing: 6

            RoundButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 12
                text: "Upload FTR"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {
                    vapefingerprint.ftr_data_upload(0x00);
                }
            }

            RoundButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 12
                text: "FTR Upload Info"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {
                    vapefingerprint.ftr_upload_info(0x00);
                }
            }

            RoundButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 12
                text: "FTR Download"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {
                    vapefingerprint.ftr_data_download()
                }
            }

            RoundButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 12
                text: "FTR Download Info"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {

                }
            }
        } // column layout1


        ColumnLayout {
            spacing: 6

            RoundButton {
                Layout.preferredWidth: 150
                radius: 12
                text: "Get Count"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {
                    vapefingerprint.system_get_count();
                }
            }

            RoundButton {
                Layout.preferredWidth: 150
                radius: 12
                text: "Get Storage"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {
                    vapefingerprint.system_get_storage_info();
                }
            }

            RoundButton {
                Layout.preferredWidth: 150
                radius: 12
                text: "Show FTR Data"
                palette {
                    button: Style.color.customButton
                    buttonText: Style.color.white
                }
                font {pixelSize: 16; bold: false;}
                onClicked: {
                    vapefingerprint.show_ftr_data();
                }
            }
        }
    } // row layout

}
