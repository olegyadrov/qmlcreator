import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
  id: timerExample
  anchors.fill: parent
  property bool running: false
  property date startTime

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: spacing

    Label {
      id: timeLabel
      Layout.fillWidth: true
      Layout.fillHeight: true
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter
      text: "00:00:000"
    }

    RowLayout {
      Button {
        Layout.fillWidth: true
        text: running ? "Stop" : "Start"
        onClicked: {
          running = !running
          if (running) startTime = new Date()
        }
      }

      Button {
        Layout.fillWidth: true
        text: "Reset"
        onClicked: {
          startTime = new Date()
          if (!running) timeLabel.text = "00:00:000"
        }
      }
    }
  }

  Timer {
    interval: 10
    repeat: true
    running: timerExample.running
    onTriggered: {
      var currentTime = new Date()
      var deltaTime = new Date(currentTime - startTime)
      timeLabel.text = Qt.formatDateTime(deltaTime, "mm:ss:zzz")
    }
  }
}
