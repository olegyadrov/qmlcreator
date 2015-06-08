import QtQuick 2.4
import QtQuick.Particles 2.0

ParticleSystem {
  anchors.fill: parent

  ImageParticle {
    source: "qrc:/resources/images/particle1.png"
    redVariation: 1
    greenVariation: 1
    blueVariation: 1
    rotationVariation: 360
    rotationVelocityVariation: 360
    entryEffect: ImageParticle.Scale
  }

  Emitter {
    anchors.centerIn: parent
    width: 10
    height: 10
    emitRate: 100
    lifeSpan: 2000
    maximumEmitted: -1
    size: 50
    endSize: -1
    velocity: AngleDirection {
      angleVariation: 360
      magnitude: 200
    }
  }
}
