import QtQuick 2.5

Rectangle {
    id: rect
    width: Math.min(parent.width / 2, parent.height / 2)
    height: width

    signal clicked()

    MouseArea {
        anchors.fill: parent
        onClicked:
            console.log("You clicked on the", rect.objectName)
    }
}
