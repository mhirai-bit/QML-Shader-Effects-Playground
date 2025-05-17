// GodRaysEffect.qml
import QtQuick

Item {
    id: root
    width: 640; height: 480

    property Item sourceItem: Rectangle {
        parent: root
        anchors.fill: parent
        color: root.backgroundColor
        Rectangle {
            id: light
            anchors.centerIn: parent
            width: 100; height: 100
            radius: width/2
            color: root.color
        }
    }

    property alias intensity: composite.u_intensity
    property alias lightPos: radialBlur.u_lightPos
    property alias lightTolerance: brightPass.u_tolerance
    property alias numSamples: radialBlur.u_numSamples
    property alias decay: radialBlur.u_decay
    property color color: "white"

    // TODO: how can I make it work even if the background color isn't black?
    readonly property color backgroundColor: "black"

    // ◆ オフスクリーンレンダー用
    ShaderEffectSource {
        id: shaderSrc
        sourceItem: root.sourceItem
        hideSource: true
        live: true
    }

    // 1) BrightPass: 明るい部分のマスク生成
    ShaderEffect {
        id: brightPass
        anchors.fill: parent
        visible: false
        layer.enabled: true

        property var sourceTexture: shaderSrc
        property vector3d u_pickColor: root.color
        property real u_tolerance: 1.73

        fragmentShader: "qrc:/BrightPass_ColorPick.frag.qsb"
    }

    // 2) RadialBlur: 放射状ブラーで光芒を生成
    ShaderEffect {
        id: radialBlur
        anchors.fill: parent
        visible: false
        layer.enabled: true

        property var   sourceTexture: brightPass
        property vector2d  u_lightPos:    Qt.vector2d((root.sourceItem.childrenRect.x + root.sourceItem.childrenRect.width/2)/root.sourceItem.width,
                                                          (root.sourceItem.childrenRect.y + root.sourceItem.childrenRect.height/2)/root.sourceItem.height)
        property int       u_numSamples:  60
        property real      u_density:     0.96
        property real      u_decay:       0.95
        property real      u_weight:      0.4
        property real      u_exposure:    0.3

        fragmentShader: "qrc:/GodRaysRadialBlur.frag.qsb"
    }

    // 3) Composite: 元シーン＋光芒を加算合成
    ShaderEffect {
        id: composite
        anchors.fill: parent
        layer.enabled: true

        property var sourceTexture: shaderSrc
        property var bloomTexture:  radialBlur
        property real    u_intensity:   1.0

        fragmentShader: "qrc:/Compose.frag.qsb"
    }
}
