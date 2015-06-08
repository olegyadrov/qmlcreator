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

      DirectionalBlur {
        id: effect
        anchors.fill: image
        source: image
      }
    }

    GridLayout {
      columns: 2

      Label { text: "Angle" }
      Slider {
        Layout.fillWidth: true
        value: 0.5
        onValueChanged: effect.angle = (value - 0.5) * 360
      }

      Label { text: "Length" }
      Slider {
        Layout.fillWidth: true
        value: 0
        maximumValue: 100
        onValueChanged: effect.length = value
      }

      Label { text: "Samples" }
      Slider {
        Layout.fillWidth: true
        value: 0
        maximumValue: 100
        onValueChanged: effect.samples = value
      }

      Label { text: "Transparent Border" }
      CheckBox {
        Layout.fillWidth: true
        checked: false
        onCheckedChanged: effect.transparentBorder = checked
      }
    }
  }
}
