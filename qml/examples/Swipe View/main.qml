import QtQuick 2.4

SwipeView {
  anchors.fill: parent
  model: ListModel {
    ListElement {
      title: "Log In"
      source: "LogInScreen.qml"
    }

    ListElement {
      title: "Register"
      source: "RegisterScreen.qml"
    }

    ListElement {
      title: "Restore Password"
      source: "RestorePasswordScreen.qml"
    }
  }
}
