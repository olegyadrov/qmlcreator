import QtQuick 2.4

Rectangle {
  width: 400
  height: 400
  color: Qt.rgba(0.35, 0.65, 0.17)
  antialiasing: true

  property double xRotation
  property double yRotation

  Text {
    anchors.centerIn: parent
    color: "white"
    font.pixelSize: 160
    text: "QML"
  }

  transform: [
    Rotation {
      origin.x: 200
      origin.y: 200
      axis { x: 1; y: 0; z: 0 }
      angle: yRotation
    },
    Rotation {
      origin.x: 200
      origin.y: 200
      axis { x: 0; y: 1; z: 0 }
      angle: xRotation
    }
  ]
}
