import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    id: player

    width: 20 * Screen.logicalPixelDensity
    height: width

    radius: width / 2
    color: "#006325"

    property double speed: 2 * Screen.logicalPixelDensity
}
