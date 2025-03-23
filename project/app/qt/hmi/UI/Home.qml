import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11

import Style 1.0

Rectangle {

    property var tabName: ["Home", "Auxiliary"]
    property var tabImage: ["qrc:/assets/icon/outline_grid_view_white_36.png",
        "qrc:/assets/icon/outline_add_to_queue_white_36.png"]

    ListModel {
        id: listTab
        Component.onCompleted: {
            for (var i = 0; i < tabName.length; ++i) {
                listTab.append({ "text": tabName[i], "source": tabImage[i] })
            }
        }
    }

    Rectangle {
        id: rectLeft
        width: parent.width * 1/5; height: parent.height
        anchors {
            top: parent.top
            left: parent.left
        }
        color: Style.color.dark
        border {width: 1; color: "#373737"}

        Rectangle {
            id: rectLogo
            width: imgLogo.width + 8
            height: imgLogo.height + 8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            color: parent.color
            radius: 12
            border.color: "gray"

            Image {
                id: imgLogo
                anchors.centerIn: parent
                width: 60; height: width
                source: "qrc:/assets/icon/c.png"
            }
        }

        ListView {
            id: lvTab
            anchors {top: rectLogo.bottom; topMargin: 20; horizontalCenter: parent.horizontalCenter}
            model: listTab
            currentIndex: 0
            highlight: Rectangle { color: "#436EFF"; radius: 5}
            width: parent.width; height: 240
            focus: true

            delegate: Item {
                width: parent.width; height: 48
                Image {
                    id: imgButton
                    width: 20; height: width
                    source: listTab.get(index).source
                    fillMode: Image.PreserveAspectFit
                    anchors {left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter}
                }
                Text {
                    color: Style.color.text
                    text: listTab.get(index).text
                    anchors {left: imgButton.right; leftMargin: 10; verticalCenter: parent.verticalCenter}
                    font { family: "Open Sans Light"; weight: Font.Medium; pixelSize: 12 }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        lvTab.currentIndex = index
                        switch (index) {
                        case 0:
                            tabPage.currentIndex = 0;
                            break

                        case 1:
                            tabPage.currentIndex = 1;
                            break;
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: body
        width: parent.width - rectLeft.width; height: parent.height
        anchors {left: rectLeft.right; top: parent.top}
        StackLayout {
            id: tabPage
            width: parent.width; height: parent.height
            currentIndex: 0

            Page1 {}
            Page2 {}
        }
    }


}
