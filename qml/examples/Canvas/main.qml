import QtQuick 2.5
import QtQuick.Window 2.2

Canvas {
    id: canvas
    anchors.fill: parent

    onPaint: {
        var ctx = canvas.getContext("2d")
        player.draw(ctx)
    }

    Item {
        id: player
        width: 10 * Screen.logicalPixelDensity
        height: 10 * Screen.logicalPixelDensity
        property color lineColor: Qt.rgba(0.35, 0.65, 0.17, 0.7)
        property real lastX: x
        property real lastY: y
        Behavior on x { NumberAnimation { duration: 500 } }
        Behavior on y { NumberAnimation { duration: 500 } }
        onXChanged: canvas.requestPaint()
        onYChanged: canvas.requestPaint()

        function draw(ctx) {
            ctx.beginPath()
            ctx.strokeStyle = lineColor
            ctx.lineWidth = 4 * Screen.logicalPixelDensity
            var radius = width / 2
            ctx.moveTo(lastX + radius, lastY + radius)
            ctx.lineTo(x + radius, y + radius)
            ctx.stroke()
            lastX = x
            lastY = y
        }

        Rectangle {
            anchors.fill: parent
            color: "#006224"
            radius: width / 2
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            player.x = mouseX - player.width / 2
            player.y = mouseY - player.height / 2
        }
    }
}
