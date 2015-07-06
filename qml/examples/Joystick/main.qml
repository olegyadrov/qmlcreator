import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Particles 2.0

Rectangle {
    id: joystickExample
    anchors.fill: parent
    color: "white"

    ParticleSystem {
        id: particleSystem
        anchors.fill: parent

        ImageParticle {
            source: "qrc:/resources/images/particle2.png"
            entryEffect: ImageParticle.Scale
            color: "#80c342"
        }
    }

    Player {
        id: player
        x: 10 * Screen.logicalPixelDensity
        y: 10 * Screen.logicalPixelDensity

        Emitter {
            anchors.centerIn: parent
            width: 1
            height: 1
            emitRate: 40
            lifeSpan: 1000
            maximumEmitted: -1
            size: 4 * Screen.logicalPixelDensity
            sizeVariation: Screen.logicalPixelDensity
            endSize: -1
            velocity: AngleDirection {
                angleVariation: 360
                magnitude: 30 * Screen.logicalPixelDensity
                magnitudeVariation: 10 * Screen.logicalPixelDensity
            }
            system: particleSystem
        }
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
