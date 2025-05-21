import QtQuick

ShaderEffect {
    fragmentShader: "qrc:/VignetteEffect.frag.qsb"
    required property var sourceTexture

    property real u_falloff: 0.4    // ぼかしの量（外側の滑らかさ）
    property real u_amount: 0.5     // 強度（暗さの程度）
    property vector2d u_center: Qt.vector2d(0.5, 0.5) // 中央の位置
    property real u_radius: 0.8     // 効果が始まる内側の半径
}
