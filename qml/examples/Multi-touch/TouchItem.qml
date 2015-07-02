import QtQuick 2.4
import QtQuick.Window 2.2

Item {
    id: touchItem

    property color color: Qt.rgba(Math.random(),
                                  Math.random(),
                                  Math.random())

    Rectangle {
        anchors.centerIn: parent

        width: 3 * Screen.logicalPixelDensity
        height: Screen.height * 2
        color: touchItem.color

        rotation: 45
    }

    Rectangle {
        anchors.centerIn: parent

        width: 3 * Screen.logicalPixelDensity
        height: Screen.height * 2
        color: touchItem.color

        rotation: -45
    }
}
