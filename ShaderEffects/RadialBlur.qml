import QtQuick

ShaderEffect {
    required property var sourceTexture

    property vector2d u_center: Qt.vector2d(0.5, 0.5)
    property int u_sampleCount: 60
    property real      u_strength: 0.005

    fragmentShader: "qrc:/RadialBlur.frag.qsb"
}
