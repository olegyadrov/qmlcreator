import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.2
import QtQuick.Scene3D 2.0
import Qt3D 2.0
import Qt3D.Renderer 2.0

Rectangle {
    id: rootItem
    anchors.fill: parent
    color: "#ffffff"

    Scene3D {
        width: Math.min(parent.width, parent.height)
        height: width
        anchors.centerIn: parent
        aspects: "input"

        Entity {
            id: sceneRoot

            Camera {
                id: camera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 40
                aspectRatio: 4/3
                nearPlane : 0.1
                farPlane : 1000.0
                position: Qt.vector3d(0.0, 0.0, 7.5)
                upVector: Qt.vector3d(0.0, 1.0, 0.0)
                viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
            }

            components: [
                FrameGraph {
                    activeFrameGraph:
                        ForwardRenderer {
                            camera: camera
                            clearColor: rootItem.color
                        }
                }
            ]

            Entity {
                components: [
                    Mesh {
                        source: "qrc:/resources/meshes/logo.obj"
                    },

                    PhongMaterial {
                        ambient: "#80c342"
                        diffuse: "#161616"
                        specular: "#000000"
                    },

                    Transform {
                        Rotate {
                            angle: xSlider.value
                            axis: Qt.vector3d(1, 0, 0)
                        }
                        Rotate {
                            angle: ySlider.value
                            axis: Qt.vector3d(0, 1, 0)
                        }
                        Rotate {
                            angle: zSlider.value
                            axis: Qt.vector3d(0, 0, 1)
                        }
                    }
                ]
            }
        }
    }

    GridLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: columnSpacing
        columns: 2

        Label { text: "X" }
        Slider {
            id: xSlider
            Layout.fillWidth: true
            minimumValue: 0
            maximumValue: 360
            value: 0
        }

        Label { text: "Y" }
        Slider {
            id: ySlider
            Layout.fillWidth: true
            minimumValue: 0
            maximumValue: 360
            value: 0
        }

        Label { text: "Z" }
        Slider {
            id: zSlider
            Layout.fillWidth: true
            minimumValue: 0
            maximumValue: 360
            value: 0
        }
    }
}
