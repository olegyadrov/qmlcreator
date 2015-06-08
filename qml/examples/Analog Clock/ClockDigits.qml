import QtQuick 2.4

Repeater {
  model: 12
  delegate: Item {
    width: parent.border.width
    height: parent.radius - width * 2
    rotation: 30 * (index + 1)
    transformOrigin: Item.Bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.verticalCenter

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.top
      text: index + 1
      rotation: -parent.rotation
      font.pixelSize: parent.width * 4
    }
  }
}
