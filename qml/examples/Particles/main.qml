import QtQuick 2.4
import QtQuick.Particles 2.0
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    /*
        For some reason, direct binding of AngleDirection.magnitude to Screen.logicalPixelDensity
        is not working in Qt 5.4.2 (but it works fine in 5.5.0, though)
    */
    property double pixelDensity
    Component.onCompleted: pixelDensity = Screen.logicalPixelDensity

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
        width: 10 * pixelDensity
        height: 10 * pixelDensity
        system: particleSystem
        emitRate: 500
        lifeSpan: 1400
        lifeSpanVariation: 200
        startTime: lifeSpan
        size: 8 * pixelDensity
        sizeVariation: 4 * pixelDensity
        velocity: AngleDirection {
            angle: 270
            angleVariation: 20
            magnitude: 50 * pixelDensity
        }
        acceleration: AngleDirection {
            angle: 270
            angleVariation: 50
            magnitude: 30 * pixelDensity
        }
    }

    Turbulence {
        id: turbulence
        width: 30 * pixelDensity
        height: width
        system: particleSystem
        strength: 200 * pixelDensity
        shape: EllipseShape { fill: true }

        Rectangle {
            width: 30 * pixelDensity
            height: 30 * pixelDensity
            radius: width / 2
            color: "red"
            opacity: 0.2
        }
    }

    MouseArea {
        anchors.fill: parent
        onMouseXChanged: turbulence.x = mouseX - 15 * pixelDensity
        onMouseYChanged: turbulence.y = mouseY - 15 * pixelDensity
    }
}
