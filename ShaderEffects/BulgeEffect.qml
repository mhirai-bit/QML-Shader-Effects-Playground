import QtQuick

ShaderEffect {
    required property var sourceTexture
    property vector2d u_center: Qt.vector2d(0.5, 0.5)
    property real u_radius: 0.6
    property real u_strength: 1.1

    fragmentShader: "qrc:/BulgeEffect.frag.qsb"
}
