import QtQuick

Item {
    id: root
    width: srcImage.width
    height: srcImage.height
    property alias source: srcImage.source
    property real threshold: 0.2
    property real intensity: 2.0

    Image {
        id: srcImage
        fillMode: Image.PreserveAspectFit
        visible: false
        layer.enabled: true
    }

    ShaderEffect {
        id: brightPass
        visible: false
        width: srcImage.width
        height: srcImage.height
        layer.enabled: true
        fragmentShader: "qrc:/BrightPass.frag.qsb"
        property var sourceTexture: srcImage
        property real threshold: root.threshold
    }

    ShaderEffect {
        id: blurX
        visible: false
        width: srcImage.width
        height: srcImage.height
        layer.enabled: true
        fragmentShader: "qrc:/BloomEffectBlurX.frag.qsb"
        property var sourceTexture: brightPass
        // テクスチャの幅から求めた１ピクセル分
        property real texelWidth: 1.0 / srcImage.width
    }

    ShaderEffect {
        id: blurY
        visible: false
        width: srcImage.width
        height: srcImage.height
        layer.enabled: true
        fragmentShader: "qrc:/BloomEffectBlurY.frag.qsb"
        property var sourceTexture: blurX
        // テクスチャの高さから求めた１ピクセル分
        property real texelHeight: 1.0 / srcImage.height
    }

    ShaderEffect {
        id: compose
        width: srcImage.width
        height: srcImage.height
        property var sourceTexture: srcImage
        property var bloomTexture: blurY
        property real u_intensity: root.intensity
        fragmentShader: "qrc:/Compose.frag.qsb"
    }
}
