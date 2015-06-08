import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

SwipeScreen {
  onSelected: usernameTextField.forceActiveFocus()

  ColumnLayout {
    anchors.centerIn: parent

    GridLayout {
      columns: 2

      Label { text: "Username" }
      TextField {
        id: usernameTextField
        Layout.fillWidth: true
      }

      Label { text: "Password" }
      TextField {
        Layout.fillWidth: true
        echoMode: TextInput.Password
      }
    }

    CheckBox {
      Layout.fillWidth: true
      text: "Remember me"
    }

    Button {
      Layout.fillWidth: true
      text: "Log In"
    }
  }
}
