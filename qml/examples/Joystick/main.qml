import QtQuick 2.4
import QtQuick.Window 2.2

Rectangle {
  id: background
  anchors.fill: parent
  color: "#eaeaea"

  Player {
    id: player
    x: 50
    y: 50
  }

  Joystick {
    id: joystick
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 8 * Screen.logicalPixelDensity
  }

  Timer {
    interval: 16
    running: true
    repeat: true
    onTriggered: {
      if (joystick.pressed) {
        player.x += joystick.inputX * player.speed
        player.y += joystick.inputY * player.speed
      }
    }
  }
}
