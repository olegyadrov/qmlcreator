import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import QtGraphicalEffects 1.0

BusyIndicator {
  style: BusyIndicatorStyle {
    indicator: Item {
      Rectangle {
        id: rect
        width: parent.width
        height: width
        color: Qt.rgba(0, 0, 0, 0)
        radius: width / 2
        border.width: width / 6
        opacity: 0
      }

      ConicalGradient {
        width: rect.width
        height: rect.height
        gradient: Gradient {
          GradientStop { position: 0.0; color: "#80c342" }
          GradientStop { position: 1.0; color: "#006325" }
        }
        source: rect

        Rectangle {
          anchors.top: parent.top
          anchors.horizontalCenter: parent.horizontalCenter
          width: rect.border.width
          height: width
          radius: width / 2
          color: "#006325"
        }

        RotationAnimation on rotation {
          from: 0
          to: 360
          duration: 800
          loops: Animation.Infinite
        }
      }
    }
  }
}
