import QtQuick 2.4

Rectangle {
    anchors.fill: parent

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#073a48" }
        GradientStop { position: 1.0; color: "#041e25" }
    }

    Snow {
        width: parent.width * 2
        height: parent.height * 2
        anchors.centerIn: parent
        xRotation: (mouseArea.mouseX / mouseArea.width - 0.5) * 50
        yRotation: -(mouseArea.mouseY / mouseArea.height - 0.5) * 50
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
