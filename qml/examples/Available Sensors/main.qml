import QtQuick 2.4
import QtQuick.Controls 1.3
import QtSensors 5.1

Item {
  anchors.fill: parent
  property var sensors

  ScrollView {
    anchors.fill: parent

    Column {
      Repeater {
        id: repeater
        delegate: Text {
          text: sensors[index]
        }
      }
    }
  }

  Component.onCompleted: {
     sensors = QmlSensors.sensorTypes()
     repeater.model = sensors.length
   }
}
