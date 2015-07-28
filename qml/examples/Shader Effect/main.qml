import QtQuick 2.5

Item {
    anchors.fill: parent

    Image {
        id: image

        width: Math.min(parent.width, parent.height) * 0.7
        height: width
        visible: false

        source: "qrc:/resources/images/icon512.png"
    }

    ShaderEffect {
        id: shaderEffect

        anchors.centerIn: parent

        width: image.width
        height: image.height

        property variant source: image
        property real amplitude: 0.007
        property real frequency: 20

        property variant time

        UniformAnimator {
            id: animator
            target: shaderEffect
            uniform: "time"
            from: 0
            to: Math.PI * 2
            duration: 600
            loops: Animation.Infinite
            running: true
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
}
