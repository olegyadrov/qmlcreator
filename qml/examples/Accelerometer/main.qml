import QtQuick 2.4
import QtQuick.Window 2.2
import QtSensors 5.1

Item {
    id: accelerometerExample
    anchors.fill: parent

    Rectangle {
        id: ball
        x: accelerometerExample.width / 2 - width / 2
        y: accelerometerExample.height / 2 - height / 2
        width: 24 * Screen.logicalPixelDensity
        height: 24 * Screen.logicalPixelDensity
        color: "#006224"
        radius: width / 2

        Behavior on x { NumberAnimation { duration: 100 } }
        Behavior on y { NumberAnimation { duration: 100 } }
    }

    Accelerometer {
        id: accelerometer
        active: true
        dataRate: 20
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            var newX = ball.x - accelerometer.reading.x * Screen.logicalPixelDensity * 3
            var newY = ball.y + accelerometer.reading.y * Screen.logicalPixelDensity * 3

            if (newX + ball.width > accelerometerExample.width)
                newX = accelerometerExample.width - ball.width
            else if (newX < 0)
                newX = 0

            if (newY + ball.height > accelerometerExample.height)
                newY = accelerometerExample.height - ball.height
            else if (newY < 0)
                newY = 0

            ball.x = newX
            ball.y = newY
        }
    }
}
