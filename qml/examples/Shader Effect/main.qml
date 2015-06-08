import QtQuick 2.4

Item {
  anchors.fill: parent

  ShaderEffect {
    id: shaderEffect
    anchors.centerIn: parent
    width: 512
    height: 512

    Behavior on scale { NumberAnimation { duration: 100 } }

    property variant source: Image { source: "qrc:/resources/images/icon512.png" }
    property real amplitude: 0.007
    property real frequency: 20
    property real time: 0

    NumberAnimation on time {
      loops: Animation.Infinite
      from: 0
      to: Math.PI * 2
      duration: 600
    }

    fragmentShader:
        "uniform lowp float qt_Opacity;" +
        "uniform highp float amplitude;" +
        "uniform highp float frequency;" +
        "uniform highp float time;" +
        "uniform sampler2D source;" +
        "varying highp vec2 qt_TexCoord0;" +
        "void main() {" +
        "    highp vec2 p = sin(time + frequency * qt_TexCoord0);" +
        "    gl_FragColor = texture2D(source, qt_TexCoord0 + amplitude * vec2(p.y, -p.x)) * qt_Opacity;" +
        "}"
  }

  MouseArea {
    anchors.fill: parent
    onPressed: shaderEffect.scale = 1.5
    onReleased: shaderEffect.scale = 1.0
  }
}
