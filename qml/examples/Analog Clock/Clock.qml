import QtQuick 2.4

Item {
  implicitWidth: 256
  implicitHeight: 256

  ClockBackground {

    ClockDigits { }

    ClockHand {
      id: hourHand
      width: parent.border.width * 0.5
      height: parent.radius - parent.border.width * 7
    }

    ClockHand {
      id: minuteHand
      width: parent.border.width * 0.5
      height: parent.radius - parent.border.width * 2
    }

    ClockHand {
      id: secondHand
      width: parent.border.width * 0.2
      height: parent.radius - parent.border.width * 2
      color: "red"
    }

    Rectangle {
      width: parent.width * 0.04
      height: width
      anchors.centerIn: parent
      radius: width / 2
      color: "black"
    }
  }

  Timer {
    running: parent.enabled
    interval: 100
    triggeredOnStart: true
    repeat: true
    onTriggered: {
      var currentTime = new Date()
      secondHand.rotation = currentTime.getSeconds() * 6
      minuteHand.rotation = currentTime.getMinutes() * 6 + currentTime.getSeconds() * 0.1
      hourHand.rotation = currentTime.getHours() * 30 + currentTime.getMinutes() * 0.5
    }
  }
}
