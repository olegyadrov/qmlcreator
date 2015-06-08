import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2

Item {
  anchors.fill: parent

  Rectangle {
    id: rect
    anchors.fill: parent
  }

  Button {
    anchors.centerIn: parent
    text: "Show Dialog"
    onClicked: dialog.visible = true
  }

  ColorDialog {
    id: dialog
    onAccepted: rect.color = color
  }
}
