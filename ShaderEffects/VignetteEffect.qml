import QtQuick

ShaderEffectSource {
    id: effectSource

    // fallOff: Defines the smoothness of the vignette transition. Range 0.0 (sharp edge) to 1.0 (gradual fade)
    property alias fallOff: shaderEffect.u_falloff

    // amount: Defines the darkness intensity of the vignette. Range 0.0 (no effect) to 1.0 (full darkening)
    property alias amount: shaderEffect.u_amount

    // center: Specifies the vignette center in normalized coordinates (x, y from 0.0 to 1.0)
    property alias center: shaderEffect.u_center

    // radius: Specifies the inner radius where the vignette effect begins. Range 0.0 (covers center) to 1.0 (only edges)
    property alias radius: shaderEffect.u_radius

    width: sourceItem.width
    height: sourceItem.height

    ShaderEffect {
        id: shaderEffect
        anchors.fill: parent
        fragmentShader: "qrc:/VignetteEffect.frag.qsb"
        property var sourceTexture: parent
        property real u_falloff: 0.4
        property real u_amount: 0.5
        property vector2d u_center: Qt.vector2d(0.5, 0.5)
        property real u_radius: 0.8
    }
}
