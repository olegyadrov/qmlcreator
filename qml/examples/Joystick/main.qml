import QtQuick 2.5
import QtQuick.Window 2.2

Rectangle {
    id: joystickExample
    anchors.fill: parent
    color: "white"

    Player {
        id: player
        x: 10 * Screen.logicalPixelDensity
        y: 10 * Screen.logicalPixelDensity
    }

    Joystick {
        id: joystick
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 8 * Screen.logicalPixelDensity
        opacity: 0.9
    }

    Timer {
        id: timer
        interval: 16
        running: true
        repeat: true

        onTriggered: {
            if (joystick.pressed) {
                var newX = player.x + joystick.inputX * player.speed
                var newY = player.y + joystick.inputY * player.speed

                if (newX + player.width > joystickExample.width)
                    newX = joystickExample.width - player.width
                else if (newX < 0)
                    newX = 0

                if (newY + player.height > joystickExample.height)
                    newY = joystickExample.height - player.height
                else if (newY < 0)
                    newY = 0

                player.x = newX
                player.y = newY
            }
        }
    }
}
