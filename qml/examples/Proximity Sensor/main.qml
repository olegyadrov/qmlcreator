import QtQuick 2.4
import QtSensors 5.1
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    ProximitySensor {
        id: sensor
        active: true
        dataRate: 20
        onReadingChanged: {
            rect.color = (reading.near) ? "#006224" : "#ffffff"
        }
    }

    Rectangle {
        id: rect
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * 0.7
        height: width
        radius: width / 2
        border.color: "#80c342"
        border.width: 10
        color: "#ffffff"
    }
}
