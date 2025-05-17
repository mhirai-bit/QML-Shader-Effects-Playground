import QtQuick

Item {
    id: root
    width: 640; height: 480
    required property url source

    property alias timeRate: glitchEffect.u_timeRate
    property real blockFactorR: 0.5
    property real blockFactorG: 1.5
    property real blockFactorB: 1.5

    Image {
        id: sourceTexture
        visible: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: root.source
    }

    ShaderEffect {
        id: glitchEffect

        anchors.fill: parent

        property real u_time: 0.0
        NumberAnimation on u_time {
            loops: -1
            duration: 1000
            from: 0.0
            to: 1.0
        }
        property real u_timeRate: 0.75
        property vector3d u_blockFactor: Qt.vector3d(root.blockFactorR,
                                                     root.blockFactorG,
                                                     root.blockFactorB)
        property var sourceTexture: sourceTexture
        fragmentShader: "qrc:/GlitchEffect.frag.qsb"
    }
}

