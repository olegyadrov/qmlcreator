import QtQuick 2.4
import QtQuick.Particles 2.0

ParticleSystem {
  anchors.fill: parent

  ImageParticle {
    source: "qrc:/resources/images/particle2.png"
    alpha: 0.9
    color: "#89feff"
    blueVariation: 0.2
    entryEffect: ImageParticle.Fade
  }

  Emitter {
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    width: 30
    height: 30
    emitRate: 500
    lifeSpan: 1400
    size: 20
    sizeVariation: 10
    velocity: AngleDirection {
      angle: 270
      magnitude: 200
    }
    acceleration: AngleDirection {
      angle: 270
      angleVariation: 50
      magnitude: 100
    }
  }

  Turbulence {
    id: turbulence
    width: 100
    height: 100
    strength: 600
    shape: EllipseShape { fill: true }

    Rectangle {
      anchors.fill: parent
      z: -1
      radius: width / 2
      color: "black"
      opacity: 0.1
    }
  }

  MouseArea {
    anchors.fill: parent
    onMouseXChanged: turbulence.x = mouseX - turbulence.width / 2
    onMouseYChanged: turbulence.y = mouseY - turbulence.height / 2
  }
}
