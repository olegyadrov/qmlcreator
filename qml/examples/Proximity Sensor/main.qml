import QtQuick 2.4
import QtSensors 5.1

Item {
  anchors.fill: parent

  ProximitySensor {
    id: sensor
    active: true
    dataRate: 20
  }

  Rectangle {
    id: rect
    anchors.centerIn: parent
    width: 500
    height: 500
    radius: width / 2
    border.color: "#80c342"
    border.width: 10
  }

  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: {
      rect.color = (sensor.reading.near) ? "#006224" : "#ffffff"
    }
  }
}
