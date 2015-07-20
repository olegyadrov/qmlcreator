import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtSensors 5.1
import QtMultimedia 5.4

Item {
    anchors.fill: parent

    function orientationToString(orientation) {
        var orientationString = ""
        switch (orientation) {
        case Qt.PrimaryOrientation:
            orientationString = "Primary"
            break
        case Qt.LandscapeOrientation:
            orientationString = "Landscape"
            break
        case Qt.PortraitOrientation:
            orientationString = "Portrait"
            break
        case Qt.InvertedLandscapeOrientation:
            orientationString = "Inverted landscape"
            break
        case Qt.InvertedPortraitOrientation:
            orientationString = "Inverted portrait"
            break
        }
        return orientationString
    }

    function openGLProfile() {
        var profileString = ""
        switch (OpenGLInfo.profile) {
        case OpenGLInfo.NoProfile:
            profileString = "No Profile"
            break
        case OpenGLInfo.CoreProfile:
            profileString = "Core"
            break
        case OpenGLInfo.CompatibilityProfile:
            profileString = "Compatibility"
            break
        }
        return profileString
    }

    function openGLRenderableType() {
        var renderableTypeString = ""
        switch (OpenGLInfo.renderableType) {
        case OpenGLInfo.Unspecified:
            renderableTypeString = "Unspecified rendering method"
            break
        case OpenGLInfo.OpenGL:
            renderableTypeString = "Desktop OpenGL rendering"
            break
        case OpenGLInfo.OpenGLES:
            renderableTypeString = "OpenGL ES rendering"
        }
    }

    function availableCameras() {
        var cameras = QtMultimedia.availableCameras
        var displayNames = []

        for (var i = 0; i < cameras.length; i++)
            displayNames.push(cameras[i].displayName)

        return displayNames
    }

    function availableSensors() {
        var sensors = QmlSensors.sensorTypes()
        var displayNames = []

        for (var attr in sensors)
            displayNames.push(sensors[attr])

        return displayNames
    }

    function refreshInfo() {
        var systemInfo = {
            "Operating System" : Qt.platform.os,
            "Screen" : {
                "Width" : Screen.width,
                "Height" : Screen.height,
                "Desktop available height" : Screen.desktopAvailableHeight,
                "Desktop available width" : Screen.desktopAvailableWidth,
                "Orientation" : orientationToString(Screen.orientation),
                "Primary orientation" : orientationToString(Screen.primaryOrientation),
                "Device pixel ratio" : Screen.devicePixelRatio,
                "Pixel density" : Screen.pixelDensity,
                "Logical pixel density" : Screen.logicalPixelDensity
            },
            "OpenGL" : {
                "Version" : OpenGLInfo.majorVersion + "." + OpenGLInfo.minorVersion,
                "Profile" : openGLProfile(),
                "Renderable type" : openGLRenderableType()
            },
            "Available Sensors" : availableSensors(),
            "Available Cameras" : availableCameras()
        }

        textArea.text = JSON.stringify(systemInfo, null, 4)
    }

    Component.onCompleted: refreshInfo()

    ColumnLayout {
        anchors.fill: parent

        TextArea {
            id: textArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            readOnly: true
            font.pixelSize: 5 * Screen.logicalPixelDensity
        }

        Button {
            text: "Refresh"
            onClicked: refreshInfo()
        }
    }
}
