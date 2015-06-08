import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

TabView {
  anchors.fill: parent

  Tab {
    title: "Input"

    Item {
      ColumnLayout {
        anchors.fill: parent
        anchors.margins: spacing
        RowLayout {
          ComboBox {
            model: ListModel {
              ListElement { text: "ComboBox" }
              ListElement { text: "ComboBox2" }
              ListElement { text: "ComboBox3" }
            }
          }

          TextField {
            Layout.fillWidth: true
            placeholderText: "TextField"
          }

          Button {
            text: "Button"
          }
        }

        GroupBox {
          title: "GroupBox"
          Layout.fillWidth: true

          GridLayout {
            rows: 3
            flow: GridLayout.TopToBottom
            anchors.fill: parent

            ExclusiveGroup { id: group }
            RadioButton {
              text: "RadioButton1"
              exclusiveGroup: group
            }
            RadioButton {
              text: "RadioButton2"
              exclusiveGroup: group
            }
            RadioButton {
              text: "RadioButton3"
              exclusiveGroup: group
            }

            CheckBox {
              text: "CheckBox1"
            }
            CheckBox {
              text: "CheckBox2"
            }
            CheckBox {
              text: "CheckBox3"
              enabled: false
            }
          }
        }

        RowLayout {
          Label {
            text: "Label"
          }

          Switch {
            id: switchComponent
            checked: true
          }

          ProgressBar {
            Layout.fillWidth: true
            indeterminate: switchComponent.checked
          }

          SpinBox {
            Layout.minimumWidth: 60
          }
        }

        ProgressBar {
          Layout.fillWidth: true
          value: sliderComponent.value
        }

        Slider {
          id: sliderComponent
          Layout.fillWidth: true
        }

        TextArea {
          Layout.fillWidth: true
          Layout.fillHeight: true
          text: "TextArea"
        }
      }
    }
  }

  Tab {
    title: "Calendar"

    Calendar { }
  }
}
