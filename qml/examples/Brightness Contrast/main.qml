import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Item {
  anchors.fill: parent

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: spacing

    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true

      Image {
        id: image
        anchors.centerIn: parent
        source: "qrc:/resources/images/icon512.png"
      }

      BrightnessContrast {
        id: effect
        anchors.fill: image
        source: image
      }
    }

    GridLayout {
      columns: 2

      Label { text: "Brightness" }
      Slider {
        Layout.fillWidth: true
        value: 0.5
        onValueChanged: effect.brightness = (value - 0.5) * 2
      }

      Label { text: "Contrast" }
      Slider {
        Layout.fillWidth: true
        value: 0.5
        onValueChanged: effect.contrast = (value - 0.5) * 2
      }
    }
  }
}
