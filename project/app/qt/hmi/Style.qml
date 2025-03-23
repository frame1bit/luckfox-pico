pragma Singleton

import QtQuick 2.10

QtObject {
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // SCREEN SIZE
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     property QtObject screen: QtObject {
        property int width: app_data.screen_width
        property int height: app_data.screen_height
    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // COLORS
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    property int cornerRadius: 18 // radius of the buttons, defined here

    property bool darkMode: app_data.darkmode

     property  QtObject color: QtObject {
        property color green: "#19D37B"
        property color greenTint: Qt.lighter(green)
        property color red: "#EA003C"
        property color redTint: Qt.lighter(red)
        property color orange: "#FF7241"
        property color orangeTint: Qt.lighter(orange)
        property color blue: "#19435E"
        property color blueTint: Qt.lighter(blue)
        property color yellow: "#FFFF00"
        property color yellowTint: Qt.lighter("#FFFF00")
        property color black: "#000000"
        property color white: "#ffffff"

        property color background: darkMode ? "#000000" : "#EAEDED"
        property color backgroundTransparent: darkMode ? "#00000000" :  "#00000000"

        property color text: darkMode ? "#ffffff" : "#000000"
        property color line: darkMode ? "#ffffff" : "#000000"

        property color highlight1: "#918682"
        property color highlight2: "#313247"

        property color light: darkMode ? "#484848" : "#CBCBCB"
        property color medium: darkMode ? "#282828" : "#D4D4D4"
        property color dark: darkMode ? "#1C1C1C" : "#ffffff"

        property color customButton: "#4343FE"
        property color customButtonPressed: "#FF5733"
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ICONS
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     property QtObject icon: QtObject {
         property string cool: "\uE91E"
         property string heat: "\uE91F"

         property string circle_full: "\uE91A"
         property string circle: "\uE91B"
         property string square_full: "\uE91C"
         property string square: "\uE91D"

         property string left_arrow: "\uE917"
         property string right_arrow: "\uE918"
         property string up_arrow: "\uE919"
         property string down_arrow: "\uE916"
         property string up_arrow_bold: "\uE923"
         property string down_arrow_bold: "\uE922"

         property string fav_add: "\uE920"
         property string fav_remove: "\uE921"

         property string close: "\uE915"
         property string home: "\uE900"
         property string menu: "\uE934"

         property string light: "\uE901"
         property string link: "\uE902"
         property string music: "\uE903"
         property string prev: "\uE909"
         property string next: "\uE904"
         property string rewind: "\uE935"
         property string fast_forward: "\uE936"
         property string pause: "\uE905"
         property string play: "\uE906"
         property string stop: "\uE93A"
         property string record: "\uE939"
         property string playlist: "\uE907"
         property string search: "\uE90C"
         property string speaker: "\uE90D"
         property string speakers: "\uE90E"
         property string radio: "\uE90A"
         property string cc: "\uE937"
         property string info: "\uE938"

         property string power_on: "\uE908"
         property string remote: "\uE90B"
         property string stairs: "\uE90F"
         property string tv: "\uE910"
         property string weather: "\uE911"
         property string climate: "\uE913"
         property string blind: "\uE914"

         property string wifi_1: "\uE924"
         property string wifi_2: "\uE925"
         property string wifi_3: "\uE926"

         property string language: "\uE927"
         property string integration: "\uE92A"
         property string battery: "\uE929"
         property string wifi_bluetooth: "\uE92C"
         property string system: "\uE92B"
         property string about: "\uE928"

         property string low_battery: "\uE92E"
         property string charging: "\uE92D"

         property string bell: "\uE92F"
         property string warning: "\uE930"

         property string eye: "\uE931"

         property string imgBack: darkMode ? "file:images/misc/dark/outline_arrow_back_white_36dp.png" :
                                                     "file:images/misc/normal/outline_arrow_back_black_36dp.png"

        property string imgForward: darkMode ? "file:images/misc/dark/outline_arrow_forward_white_36dp.png" :
                                                     "file:images/misc/normal/outline_arrow_forward_black_36dp.png"

        property string imgSuperAccount: darkMode ? "file:images/misc/dark/outline_supervisor_account_white_48dp.png" :
                                                     "file:images/misc/normal/outline_supervisor_account_black_48dp.png"
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // FONT STYLES
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     property QtObject font: QtObject {
        property font button: Qt.font({
                            family: "Open Sans Regular",
                            weight: Font.Normal,
                            pixelSize: 27,
                            lineHeight: 1
                        })
    }
}
