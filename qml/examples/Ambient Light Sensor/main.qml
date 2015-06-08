import QtQuick 2.4
import QtSensors 5.1

Item {
  anchors.fill: parent

  AmbientLightSensor {
    id: sensor
    active: true
    dataRate: 20
  }

  Text {
    id: label
    anchors.centerIn: parent
  }

  Timer {
    interval: 100
    running: true
    repeat: true
    onTriggered: {
      switch (sensor.reading.lightLevel) {
      case AmbientLightReading.Undefined:
        label.text = "The light level is unknown"
        break
      case AmbientLightReading.Dark:
        label.text = "It is dark"
        break
      case AmbientLightReading.Twilight:
        label.text = "It is moderately dark"
        break
      case AmbientLightReading.Light:
        label.text = "It is light"
        break
      case AmbientLightReading.Bright:
        label.text = "It is bright"
        break
      case AmbientLightReading.Sunny:
        label.text = "It is very bright"
        break
      }
    }
  }
}
