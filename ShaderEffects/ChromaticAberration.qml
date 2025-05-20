import QtQuick

ShaderEffect {

    required property var sourceTexture
    property real u_redOffset: 0.08
    property real u_greenOffset: 0.06
    property real u_blueOffset: -0.06
    property vector2d u_focusPoint: Qt.vector2d(0.5, 0.5)

    fragmentShader: "qrc:/ChromaticAberration.frag.qsb"
}
