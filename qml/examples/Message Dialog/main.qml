import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2

Item {
  anchors.fill: parent

  Button {
    anchors.centerIn: parent
    text: "Show Dialog"
    onClicked: dialog.visible = true
  }

  MessageDialog {
    id: dialog
    title: "Breaking News!"
    text: "QML Creator is now available on App Store!"
  }
}
