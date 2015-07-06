import QtQuick 2.4
import QtQuick.Window 2.2

Item {
    id: joystick
    implicitWidth: 60 * Screen.logicalPixelDensity
    implicitHeight: 60 * Screen.logicalPixelDensity
    property double inputX
    property double inputY
    property alias pressed: mouseArea.pressed

    Rectangle {
        anchors.fill: parent
        border.width: 3 * Screen.logicalPixelDensity
        border.color: "#1e1b18"
        radius: width / 2
    }

    Rectangle {
        id: handle
        width: 20 * Screen.logicalPixelDensity
        height: 20 * Screen.logicalPixelDensity
        anchors.centerIn: joystick
        anchors.onHorizontalCenterOffsetChanged:
            joystick.inputX = anchors.horizontalCenterOffset / (joystick.width / 2 - handle.width / 2)
        anchors.onVerticalCenterOffsetChanged:
            joystick.inputY = anchors.verticalCenterOffset / (joystick.height / 2 - handle.height / 2)
        radius: width / 2
        color: "#1e1b18"
    }

    NumberAnimation {
        id: returnAnimation
        target: handle.anchors
        properties: "horizontalCenterOffset,verticalCenterOffset"
        to: 0
        duration: 200
        easing.type: Easing.OutSine
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        property int startX
        property int startY
        property bool fingerOutOfBounds:
            (mouseX - startX) * (mouseX - startX) + (mouseY-startY) * (mouseY-startY) < (joystick.width / 2 - handle.width / 2) * (joystick.width / 2 - handle.width / 2)
        onPressed: {
            startX = mouseX
            startY = mouseY
            joystick.anchors.horizontalCenterOffset = mouseX - width / 2
            joystick.anchors.verticalCenterOffset = mouseY - height / 2
        }
        onPositionChanged: {
            if (fingerOutOfBounds) {
                handle.anchors.horizontalCenterOffset = mouseX - startX
                handle.anchors.verticalCenterOffset = mouseY - startY
            } else {
                var angle = Math.atan2(mouseY - startY, mouseX - startX)
                handle.anchors.horizontalCenterOffset = Math.cos(angle) * (joystick.width / 2 - handle.width / 2)
                handle.anchors.verticalCenterOffset = Math.sin(angle) * (joystick.width / 2 - handle.width / 2)
            }
        }
        onReleased: returnAnimation.start()
    }
}
