import QtQuick 2.5

Item {
    anchors.fill: parent

    Image {
        id: image
        width: Math.min(parent.width, parent.height) * 0.7
        height: width
        anchors.centerIn: parent
        source: "qrc:/resources/images/icon512.png"

        property double xRotation: (mouseArea.mouseX / mouseArea.width - 0.5) * 60
        property double yRotation: -(mouseArea.mouseY / mouseArea.height - 0.5) * 60

        transform: [
            Rotation {
                origin.x: image.width / 2
                origin.y: image.height / 2
                axis { x: 1; y: 0; z: 0 }
                angle: image.xRotation
            },
            Rotation {
                origin.x: image.width / 2
                origin.y: image.height / 2
                axis { x: 0; y: 1; z: 0 }
                angle: image.yRotation
            }
        ]
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
