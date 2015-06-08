import QtQuick 2.4

Canvas {
  id: canvas
  width: parent.width
  height: parent.height
  antialiasing: true

  onPaint: {
    var ctx = canvas.getContext("2d")
    player.draw(ctx)
  }

  Item {
    id: player
    width: 50
    height: 50
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
      ctx.lineWidth = 20
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
      antialiasing: true
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
