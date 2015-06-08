import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtSensors 5.1

Item {
  anchors.fill: parent

  Accelerometer {
    id: accelerometer
    active: true
    dataRate: 20
  }

  Rectangle {
    anchors.centerIn: parent
    width: 500
    height: 500
    radius: width / 2
    border.color: "#80c342"
    border.width: 10
  }

  Rectangle {
    id: ball
    width: 100
    height: 100
    color: "#006224"
    radius: width / 2
    property int centerX: parent.width / 2 - width / 2
    property int centerY: parent.height / 2 - height / 2

    Behavior on x { NumberAnimation { duration: 100 } }
    Behavior on y { NumberAnimation { duration: 100 } }
  }

  ColumnLayout {
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: spacing

    Text {
      id: xValueText
      text: "x: 0"
    }

    Text {
      id: yValueText
      text: "y: 0"
    }
  }

  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: {
      ball.x = ball.centerX - accelerometer.reading.x * 30
      ball.y = ball.centerY + accelerometer.reading.y * 30
      xValueText.text = "x: " + accelerometer.reading.x.toFixed(2)
      yValueText.text = "y: " + accelerometer.reading.y.toFixed(2)
    }
  }
}
