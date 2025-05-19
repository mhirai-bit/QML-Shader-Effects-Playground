import QtQuick

Rectangle {
    id: root
    width: 200; height: 200
    required property var source
    color: "transparent"
    clip: true

    // 1 ブロック = blockSize ピクセル
    property real blockSize:    20.0

    // ドラッグ／リサイズ用プロパティ
    property real startMouseX;  property real startMouseY
    property real startX;       property real startY
    property real startW;       property real startH
    property real fixedOppX;    property real fixedOppY
    property int  handleSize: 12

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
