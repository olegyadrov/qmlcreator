import QtQuick 2.4

Rectangle {
    anchors.centerIn: parent
    width: Math.min(parent.width, parent.height) - 20
    height: width
    radius: width / 2
    color: "#eaeaea"
    border.width: width * 0.03
    border.color: "black"
}
