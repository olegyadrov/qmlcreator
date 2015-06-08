import QtQuick 2.4
import QtQuick.Window 2.2

Column {
  anchors.centerIn: parent

  Text {
    text: "Width: " + Screen.width
  }

  Text {
    text: "Height: " + Screen.height
  }

  Text {
    text: "Desktop Available Width: " + Screen.desktopAvailableWidth
  }

  Text {
    text: "Desktop Available Height: " + Screen.desktopAvailableHeight
  }

  Text {
    text: "Logical Pixel Density: " + Screen.logicalPixelDensity
  }

  Text {
    text: "Orientation: " + ((Screen.orientation == Qt.PortraitOrientation) ? "Portrait" : "Landscape")
  }

  Text {
    text: "Primary Orientation: " + ((Screen.primaryOrientation == Qt.PortraitOrientation) ? "Portrait" : "Landscape")
  }
}
