import QtQuick 2.5

Item {
    anchors.fill: parent

    MultiPointTouchArea {
        id: touchArea
        anchors.fill: parent

        touchPoints: [
            TouchPoint { id: point1 },
            TouchPoint { id: point2 },
            TouchPoint { id: point3 },
            TouchPoint { id: point4 },
            TouchPoint { id: point5 },
            TouchPoint { id: point6 },
            TouchPoint { id: point7 },
            TouchPoint { id: point8 },
            TouchPoint { id: point9 },
            TouchPoint { id: point10 }
        ]
    }

    Repeater {
        model: touchArea.touchPoints.length
        delegate:
            TouchItem {
                x: touchArea.touchPoints[index].x
                y: touchArea.touchPoints[index].y
                visible: touchArea.touchPoints[index].pressed
            }
    }
}
