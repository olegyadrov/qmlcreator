import QtQuick 2.4
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    Rectangle {
        id: gradient
        width: 1
        height: text.font.pixelSize

        gradient: Gradient {
            GradientStop { position: 0; color: "#80c342" }
            GradientStop { position: 1; color: "#006325" }
        }

        visible: false
        layer.enabled: true
        layer.smooth: true
    }

    Text {
        id: text
        anchors.centerIn: parent
        font.pixelSize: 80 * Screen.logicalPixelDensity
        font.family: "Roboto"
        text: "Qt"
        layer.enabled: true
        layer.smooth: true
        layer.samplerName: "maskSource"
        layer.effect: ShaderEffect {
            property var colorSource: gradient
            fragmentShader: "
                uniform lowp sampler2D colorSource;
                uniform lowp sampler2D maskSource;
                uniform lowp float qt_Opacity;
                varying highp vec2 qt_TexCoord0;
                void main() {
                    gl_FragColor =
                        texture2D(colorSource, qt_TexCoord0)
                        * texture2D(maskSource, qt_TexCoord0).a
                        * qt_Opacity;
                }
            "
        }
    }
}
