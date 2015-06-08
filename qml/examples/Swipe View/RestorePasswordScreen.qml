import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

SwipeScreen {
  onSelected: emailTextField.forceActiveFocus()

  ColumnLayout {
    anchors.centerIn: parent

    RowLayout {
      Label { text: "Email" }
      TextField {
        id: emailTextField
        Layout.fillWidth: true
      }
    }

    Button {
      Layout.fillWidth: true
      text: "Send instructions"
    }
  }
}
