import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent

    Image {
        id: image
        width: Math.min(parent.width, parent.height) * 0.7
        height: width
        anchors.centerIn: parent
        source: "qrc:/resources/images/icon512.png"
    }

    BrightnessContrast {
        id: effect
        anchors.fill: image
        source: image
        brightness: brightnessSlider.value
        contrast: contrastSlider.value
    }

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: columnSpacing
        columns: 2

        Label { text: "Brightness" }
        Slider {
            id: brightnessSlider
            Layout.fillWidth: true
            minimumValue: -1
            maximumValue: 1
            value: 0.5
        }

        Label { text: "Contrast" }
        Slider {
            id: contrastSlider
            Layout.fillWidth: true
            minimumValue: -1
            maximumValue: 1
            value: -0.5
        }
    }
}
