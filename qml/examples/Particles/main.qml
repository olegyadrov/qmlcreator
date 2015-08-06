import QtQuick 2.5
import QtQuick.Particles 2.0
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    ParticleSystem {
        id: particleSystem
    }

    ImageParticle {
        system: particleSystem
        source: "qrc:/resources/images/particle2.png"
        alpha: 0.7
        color: "#2d7393"
        blueVariation: 0.1
        entryEffect: ImageParticle.Fade
    }

    Emitter {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: 10 * Screen.logicalPixelDensity
        height: 10 * Screen.logicalPixelDensity
        system: particleSystem
        emitRate: 500
        lifeSpan: 1400
        lifeSpanVariation: 200
        startTime: lifeSpan
        size: 8 * Screen.logicalPixelDensity
        sizeVariation: 4 * Screen.logicalPixelDensity
        velocity: AngleDirection {
            angle: 270
            angleVariation: 20
            magnitude: 50 * Screen.logicalPixelDensity
        }
        acceleration: AngleDirection {
            angle: 270
            angleVariation: 50
            magnitude: 30 * Screen.logicalPixelDensity
        }
    }

    Turbulence {
        id: turbulence
        width: 30 * Screen.logicalPixelDensity
        height: width
        system: particleSystem
        strength: 200 * Screen.logicalPixelDensity
        shape: EllipseShape { fill: true }

        Rectangle {
            width: 30 * Screen.logicalPixelDensity
            height: 30 * Screen.logicalPixelDensity
            radius: width / 2
            color: "red"
            opacity: 0.2
        }
    }

    MouseArea {
        anchors.fill: parent
        onMouseXChanged: turbulence.x = mouseX - 15 * Screen.logicalPixelDensity
        onMouseYChanged: turbulence.y = mouseY - 15 * Screen.logicalPixelDensity
    }
}
