import QtQuick 2.4
import QtQuick.Window 2.2

Rectangle {
  id: player
  width: 20 * Screen.logicalPixelDensity
  height: width
  color: "#1e1b18"
  antialiasing: true
  property double speed: 2 * Screen.logicalPixelDensity

  RotationAnimation on rotation {
    from: 0
    to: 360
    duration: 2000
    loops: Animation.Infinite
  }
}
