import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import Qt.WebSockets 1.0

Item {
  anchors.fill: parent

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: spacing

    RowLayout {
      CheckBox {
        id: checkBox
        text: "Active"
      }

      TextField {
        id: messageTextField
        Layout.fillWidth: true
        placeholderText: "Message"
      }

      Button {
        text: "Send"
        enabled: messageTextField.length > 0
        onClicked: {
          textArea.text += "Sent message: " + messageTextField.text + "\n"
          socket.sendTextMessage(messageTextField.text)
          messageTextField.text = ""
        }
      }
    }

    TextArea {
      id: textArea
      Layout.fillWidth: true
      Layout.fillHeight: true
      readOnly: true
    }
  }

  WebSocket {
    id: socket
    url: "ws://echo.websocket.org"
    onTextMessageReceived: {
      textArea.text += "Received message: " + message + "\n"
    }
    onStatusChanged: {
      var statusString = "Current status: "

      switch (socket.status) {
      case WebSocket.Connecting:
        statusString += "Connecting"
        break
      case WebSocket.Open:
        statusString += "Open"
        break
      case WebSocket.Closing:
        statusString += "Connecting"
        break
      case WebSocket.Closed:
        statusString += "Closed"
        break
      case WebSocket.Error:
        statusString += "Error (" + socket.errorString + ")"
        break
      }

      textArea.text += statusString + "\n"
    }

    active: checkBox.checked
  }
}
