import QtQuick 2.4

Item {
  anchors.fill: parent

  property var rectangles: new Array(0)
  property var colors: ["red", "orange", "yellow", "green", "lightblue", "blue", "purple",
    "red", "orange", "yellow", "green", "lightblue", "blue", "purple" ]

  MultiPointTouchArea {
    id: touchArea
    anchors.fill: parent
    maximumTouchPoints: 14

    onTouchUpdated: {
      for (var i = 0; i < touchPoints.length; i++) {
        var point = touchPoints[i]
        var rect = rectangles[point.pointId]
        rect.visible = point.pressed
        rect.x = point.x - rect.width / 2
        rect.y = point.y - rect.height / 2
      }
    }

    onReleased: {
      for (var i = 0; i < touchPoints.length; i++) {
        var point = touchPoints[i]
        var rect = rectangles[point.pointId]
        rect.visible = false
      }
    }
  }
  Repeater {
    model: touchArea.maximumTouchPoints

    delegate:
        Rectangle {
      id: rect
      width: 100
      height: 100
      radius: width / 2
      color: colors[index]
      visible: false
      Component.onCompleted: rectangles.push(rect)
    }
  }
}
