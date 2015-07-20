import QtQuick 2.4
import QtSensors 5.1

Item {
    anchors.fill: parent

    function lightLevelToString(lightLevel) {
        var lightLevelDescription = ""

        switch (lightLevel) {
        case AmbientLightReading.Undefined:
            lightLevelDescription = "The light level is unknown"
            break
        case AmbientLightReading.Dark:
            lightLevelDescription = "It is dark"
            break
        case AmbientLightReading.Twilight:
            lightLevelDescription = "It is moderately dark"
            break
        case AmbientLightReading.Light:
            lightLevelDescription = "It is light"
            break
        case AmbientLightReading.Bright:
            lightLevelDescription = "It is bright"
            break
        case AmbientLightReading.Sunny:
            lightLevelDescription = "It is very bright"
            break
        }

        return lightLevelDescription
    }

    AmbientLightSensor {
        id: sensor
        active: true
        dataRate: 20
        onReadingChanged: {
            label.text = lightLevelToString(reading.lightLevel)
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: lightLevelToString(AmbientLightReading.Undefined)
    }
}
