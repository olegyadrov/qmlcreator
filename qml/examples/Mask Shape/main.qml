import QtQuick 2.4
import QtQuick.Particles 2.0

ParticleSystem {
  anchors.fill: parent

  ImageParticle {
    source: "qrc:/resources/images/particle2.png"
    color: "#80c342"
    entryEffect: ImageParticle.Scale
  }

  Emitter {
    anchors.centerIn: parent
    width: 240
    height: 240
    scale: 2.5
    emitRate: 600
    lifeSpan: 3000
    size: 10
    shape: MaskShape {
      source: "qrc:/qml/Images/mask.png"
    }
  }
}
