import QtQuick 2.5
import QtQuick.Controls 1.3
import QtLocation 5.3
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    Plugin {
        id: mapPlugin
        locales: ["en_US"]
        preferred: ["osm"]
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        zoomLevel: (maximumZoomLevel - minimumZoomLevel) / 2
        center {
            latitude: 37.745
            longitude: -122.204
        }

        property double zoomStep: (maximumZoomLevel - minimumZoomLevel) / 20

        Behavior on zoomLevel {
            NumberAnimation {
                duration: 200
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 6 * Screen.logicalPixelDensity

        Button {
            width: height
            text: "+"
            onClicked: {
                var newZoom = map.zoomLevel + map.zoomStep
                if (newZoom > map.maximumZoomLevel)
                    newZoom = map.maximumZoomLevel
                map.zoomLevel = newZoom
            }
        }

        Button {
            width: height
            text: "-"
            onClicked: {
                var newZoom = map.zoomLevel - map.zoomStep
                if (newZoom < map.minimumZoomLevel)
                    newZoom = map.minimumZoomLevel
                map.zoomLevel = newZoom
            }
        }
    }
}
