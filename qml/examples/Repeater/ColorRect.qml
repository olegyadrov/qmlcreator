import QtQuick 2.4

Rectangle {
  id: colorRect
  width: 100
  height: 100
  color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
  antialiasing: true

  Behavior on color {
    ColorAnimation {
      duration: 1000
    }
  }

  Timer {
    interval: 3000 * Math.random()
    repeat: true
    running: true
    triggeredOnStart: true
    onTriggered: parent.color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      if (!animation.running) {
        colorRect.z = 2
        animation.start()
      }
    }
  }

  RotationAnimation on rotation {
    id: animation
    from: 0
    to: 360
    duration: 1000
    running: false
    loops: 1
    onStopped: colorRect.z = 1
  }
}
