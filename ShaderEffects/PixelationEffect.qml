import QtQuick

Item {
    id: root
    width: 200; height: 200
    required property var source

    // 1 ブロック = blockSize ピクセル
    property real blockSize:    20.0

    ShaderEffectSource {
        id: sourceTexture
        live: true
        sourceItem: root.source
        sourceRect: Qt.rect(
                        mosaicArea.x, mosaicArea.y,
                        mosaicArea.width, mosaicArea.height
                        )
    }

    ShaderEffect {
        id: pixelationEffect
        anchors.fill: parent
        property var     sourceTexture: sourceTexture
        property vector2d u_pixels: Qt.vector2d(
                                        mosaicArea.width  / root.blockSize,
                                        mosaicArea.height / root.blockSize
                                        )
        fragmentShader: "qrc:/PixelationEffect.frag.qsb"

        MouseArea {
            id: centerHandle
            anchors.fill: parent
            anchors.margins: mosaicArea.handleSize
            cursorShape: Qt.SizeAllCursor
            drag.target: mosaicArea
            drag.axis:   Drag.XAndYAxis
            preventStealing: true
            onPressed: mouse => mouse.accepted = true
        }
    }
}
