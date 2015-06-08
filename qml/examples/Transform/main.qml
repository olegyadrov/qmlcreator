import QtQuick 2.4

Item {
  anchors.fill: parent

  Rect {
    anchors.centerIn: parent
    xRotation: (mouseArea.mouseX / mouseArea.width - 0.5) * 45
    yRotation: -(mouseArea.mouseY / mouseArea.height - 0.5) * 45
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
  }
}
