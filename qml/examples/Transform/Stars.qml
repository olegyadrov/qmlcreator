import QtQuick 2.4
import QtQuick.Particles 2.0
import QtQuick.Window 2.2

Item {
    id: snow

    property double xRotation
    property double yRotation

    transform: [
        Rotation {
            origin.x: snow.width / 2
            origin.y: snow.height / 2
            axis { x: 1; y: 0; z: 0 }
            angle: yRotation
        },
        Rotation {
            origin.x: snow.width / 2
            origin.y: snow.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: xRotation
        }
    ]

    ParticleSystem {
        id: particleSystem

        ImageParticle {
            source: "qrc:/resources/images/particle3.png"
            color: "#ffdd00"
            alpha: 0.3
            rotationVariation: 360
            rotationVelocityVariation: 120
        }
    }

    Emitter {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        emitRate: 30
        lifeSpan: snow.height * 2
        startTime: lifeSpan
        maximumEmitted: -1
        size: 4 * Screen.logicalPixelDensity
        sizeVariation: 2 * Screen.logicalPixelDensity
        endSize: -1
        velocity: AngleDirection {
            angle: 90
            angleVariation: 10
            magnitude: 80 * Screen.logicalPixelDensity
            magnitudeVariation: 30 * Screen.logicalPixelDensity
        }
        system: particleSystem
    }
}
