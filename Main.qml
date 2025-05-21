import QtQuick
import QtQuick.Controls

import ShaderEffects

Window {
    id: root
    width: dummy.implicitWidth
    height: dummy.implicitHeight
    visible: true
    title: qsTr("Hello World")

    readonly property url imageUrl: "qrc:/qt/qml/ShaderEffectsQMLPlayground/images/beach.jpg"
    Image {
        visible: false
        id: dummy
        source: root.imageUrl
    }

    ListView {
        anchors.fill: parent

        model: [
            vignetteEffectImage,
            radialBlurImage,
            chromaticAberrationImage,
            distortionEffectImage,
            pixelationEffectImage,
            glitchEffectImage,
            godRaysComponent,
            bloomEffectImage,
            rippleEffectImage,
            genieEffectImage]

        delegate: Loader {
            sourceComponent: modelData
        }
    }

    Component {
        id: genieEffectImage
        Rectangle {
            id: screen
            width: root.width
            height: root.height
            color: "gray"

            Image {
                id: sourceImage
                visible: false
                width: parent.width
                fillMode: Image.PreserveAspectFit
                source: root.imageUrl
            }

            GenieEffect {
                id: genieEffect
                anchors.fill: parent
                source: sourceImage
                side: (button.x + button.width/2)/screen.width
            }

            Rectangle {
                id: button
                anchors.bottom: parent.bottom
                width: buttonText.width + 20
                height: buttonText.height + 10
                color: "lightgray"
                radius: 8

                Text {
                    id: buttonText
                    anchors.centerIn: parent
                    text: "Click Me"
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent

                    drag.target: button
                    drag.axis: Drag.XAxis
                    drag.minimumX: 0
                    drag.maximumX: screen.width - button.width

                    onClicked: {
                        genieEffect.minimized = !genieEffect.minimized
                    }
                }
            }
        }
    }

    Component {
        id: rippleEffectImage
        Rectangle {
            id: screen
            width: root.width
            height: root.height
            color: "gray"

            Image {
                id: sourceImage
                visible: false
                width: parent.width
                fillMode: Image.PreserveAspectFit
                source: root.imageUrl
            }

            RippleEffect {
                id: rippleEffect
                anchors.fill: parent
                source: sourceImage
            }

            MouseArea {
                anchors.fill: parent
                onClicked: mouse => {
                               rippleEffect.addRipple(mouse.x / screen.width, mouse.y / screen.height)
                           }
            }
        }
    }

    Component {
        id: bloomEffectImage
        BloomEffect {
            Column {
                spacing: 12
                Row {
                    Text {
                        text: "Threshold"
                        color: "white"
                    }
                    Slider {
                        id: thresholdSlider
                        value: 0.5
                        from: 0.0
                        to: 1.0
                    }
                }
                Row {
                    Text {
                        text: "Intensity"
                        color: "white"
                    }
                    Slider {
                        id: intensitySlider
                        value: 0.5
                        from: 0.0
                        to: 10.0
                    }
                }
            }
            intensity: intensitySlider.value
            threshold: thresholdSlider.value

            source: root.imageUrl
        }
    }

    Component {
        id: godRaysComponent

        GodRaysEffect {
            id: godrayEffect
            width: root.width
            height: root.height
            color: "red"
            readonly property color textColor: Qt.rgba(
                                                   1 - godrayEffect.backgroundColor.r,
                                                   1 - godrayEffect.backgroundColor.g,
                                                   1 - godrayEffect.backgroundColor.b,
                                                   1.0
                                                   )

            Column {
                spacing: 8

                // Intensity
                Row {
                    spacing: 8
                    Text {
                        text: "Intensity"
                        color: godrayEffect.textColor
                    }
                    Slider {
                        from: 0; to: 5; stepSize: 0.1
                        value: godrayEffect.intensity
                        onMoved: godrayEffect.intensity = value
                    }
                    Text {
                        text: godrayEffect.intensity.toFixed(2)
                        color: godrayEffect.textColor
                    }
                }

                // Light Position X
                Row {
                    spacing: 8
                    Text {
                        text: "Light X"
                        color: godrayEffect.textColor
                    }
                    Slider {
                        from: 0; to: 1; stepSize: 0.01
                        value: godrayEffect.lightPos.x
                        onMoved: godrayEffect.lightPos =
                                 Qt.vector2d(value, godrayEffect.lightPos.y)
                    }
                    Text {
                        text: godrayEffect.lightPos.x.toFixed(2)
                        color: godrayEffect.textColor
                    }
                }

                // Light Position Y
                Row {
                    spacing: 8
                    Text {
                        text: "Light Y"
                        color: godrayEffect.textColor
                    }
                    Slider {
                        from: 0; to: 1; stepSize: 0.01
                        value: godrayEffect.lightPos.y
                        onMoved: godrayEffect.lightPos =
                                 Qt.vector2d(godrayEffect.lightPos.x, value)
                    }
                    Text {
                        text: godrayEffect.lightPos.y.toFixed(2)
                        color: godrayEffect.textColor
                    }
                }

                // Tolerance (color pick)
                Row {
                    spacing: 8
                    Text {
                        text: "Tolerance"
                        color: godrayEffect.textColor
                    }
                    Slider {
                        from: 0; to: Math.sqrt(3); stepSize: 0.01    // 最大 √3 ≈1.732
                        value: godrayEffect.lightTolerance
                        onMoved: godrayEffect.lightTolerance = value
                    }
                    Text {
                        text: godrayEffect.lightTolerance.toFixed(2)
                        color: godrayEffect.textColor
                    }
                }

                // Number of Samples
                Row {
                    spacing: 8
                    Text {
                        text: "Samples"
                        color: godrayEffect.textColor
                    }
                    Slider {
                        from: 1; to: 200; stepSize: 1
                        value: godrayEffect.numSamples
                        onMoved: godrayEffect.numSamples = value
                    }
                    Text {
                        text: godrayEffect.numSamples
                        color: godrayEffect.textColor
                    }
                }

                // Decay
                Row {
                    spacing: 8
                    Text {
                        text: "Decay"
                        color: godrayEffect.textColor
                    }
                    Slider {
                        from: 0; to: 1; stepSize: 0.01
                        value: godrayEffect.decay
                        onMoved: godrayEffect.decay = value
                    }
                    Text {
                        text: godrayEffect.decay.toFixed(2)
                        color: godrayEffect.textColor
                    }
                }
            }

        }
    }

    Component {
        id: glitchEffectImage

        GlitchEffect {
            id: glitchEffect
            source: root.imageUrl

            Column {
                spacing: 8

                // Time Rate
                Row {
                    spacing: 8
                    Text {
                        text: "Time Rate"
                        color: "white"
                    }
                    Slider {
                        from: 0; to: 1; stepSize: 0.01
                        value: glitchEffect.timeRate
                        onMoved: glitchEffect.timeRate = value
                    }
                    Text {
                        text: glitchEffect.timeRate.toFixed(2)
                        color: "white"
                    }
                }

                // Block Factor R
                Row {
                    spacing: 8
                    Text {
                        text: "Block R"
                        color: "white"
                    }
                    Slider {
                        from: 0; to: 2; stepSize: 0.01
                        value: glitchEffect.blockFactorR
                        onMoved: glitchEffect.blockFactorR = value
                    }
                    Text {
                        text: glitchEffect.blockFactorR.toFixed(2)
                        color: "white"
                    }
                }

                // Block Factor G
                Row {
                    spacing: 8
                    Text {
                        text: "Block G"
                        color: "white"
                    }
                    Slider {
                        from: 0; to: 2; stepSize: 0.01
                        value: glitchEffect.blockFactorG
                        onMoved: glitchEffect.blockFactorG = value
                    }
                    Text {
                        text: glitchEffect.blockFactorG.toFixed(2)
                        color: "white"
                    }
                }

                // Block Factor B
                Row {
                    spacing: 8
                    Text {
                        text: "Block B"
                        color: "white"
                    }
                    Slider {
                        from: 0; to: 2; stepSize: 0.01
                        value: glitchEffect.blockFactorB
                        onMoved: glitchEffect.blockFactorB = value
                    }
                    Text {
                        text: glitchEffect.blockFactorB.toFixed(2)
                        color: "white"
                    }
                }
            }
        }
    }

    Component {
        id: pixelationEffectImage

        Item {
            width: root.width
            height: root.height
            Image {
                id: sourceImage
                source: root.imageUrl
            }
            PixelationEffect {
                id: mosaicArea
                source: sourceImage

                // ドラッグ／リサイズ用プロパティ
                property real startMouseX;  property real startMouseY
                property real startX;       property real startY
                property real startW;       property real startH
                property real fixedOppX;    property real fixedOppY
                property int  handleSize: 12

                // 左エッジ
                Rectangle {
                    x: 0; y: mosaicArea.handleSize
                    width: mosaicArea.handleSize
                    height: mosaicArea.height - mosaicArea.handleSize*2
                    color: "transparent"
                    MouseArea {
                        id: leftHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeHorCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       mosaicArea.startMouseX = mosaicArea.mapFromItem(leftHandle, mouse.x, mouse.y).x
                                       mosaicArea.startX      = mosaicArea.x
                                       mosaicArea.startW      = mosaicArea.width
                                       mosaicArea.fixedOppX   = mosaicArea.x + mosaicArea.width
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(leftHandle, mouse.x, mouse.y)
                                               var dx = xyInMosaicArea.x - mosaicArea.startMouseX
                                               mosaicArea.x     = mosaicArea.startX + dx
                                               mosaicArea.width = mosaicArea.fixedOppX - mosaicArea.x
                                           }
                    }
                }

                // 右エッジ
                Rectangle {
                    x: mosaicArea.width - mosaicArea.handleSize; y: mosaicArea.handleSize
                    width: mosaicArea.handleSize
                    height: mosaicArea.height - mosaicArea.handleSize*2
                    color: "transparent"
                    MouseArea {
                        id: rightHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeHorCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       mosaicArea.startMouseX = mosaicArea.mapFromItem(rightHandle, mouse.x, mouse.y).x
                                       mosaicArea.startW      = mosaicArea.width
                                       mosaicArea.fixedOppX   = mosaicArea.x
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(rightHandle, mouse.x, mouse.y)
                                               var dx = xyInMosaicArea.x - mosaicArea.startMouseX
                                               mosaicArea.width = Math.max(1, mosaicArea.startW + dx)
                                               mosaicArea.x     = mosaicArea.fixedOppX
                                           }
                    }
                }

                // 上エッジ
                Rectangle {
                    x: mosaicArea.handleSize; y: 0
                    width: mosaicArea.width - mosaicArea.handleSize*2
                    height: mosaicArea.handleSize
                    color: "transparent"
                    MouseArea {
                        id: topHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeVerCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       mosaicArea.startMouseY = mosaicArea.mapFromItem(topHandle, mouse.x, mouse.y).y
                                       mosaicArea.startY      = mosaicArea.y
                                       mosaicArea.startH      = mosaicArea.height
                                       mosaicArea.fixedOppY   = mosaicArea.y + mosaicArea.height
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(topHandle, mouse.x, mouse.y)
                                               var dy = xyInMosaicArea.y - mosaicArea.startMouseY
                                               mosaicArea.y      = mosaicArea.startY + dy
                                               mosaicArea.height = mosaicArea.fixedOppY - mosaicArea.y
                                           }
                    }
                }

                // 下エッジ
                Rectangle {
                    x: mosaicArea.handleSize; y: mosaicArea.height - mosaicArea.handleSize
                    width: mosaicArea.width - mosaicArea.handleSize*2
                    height: mosaicArea.handleSize
                    color: "transparent"
                    MouseArea {
                        id: bottomHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeVerCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       mosaicArea.startMouseY = mosaicArea.mapFromItem(bottomHandle, mouse.x, mouse.y).y
                                       mosaicArea.startH      = mosaicArea.height
                                       mosaicArea.fixedOppY   = mosaicArea.y
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(bottomHandle, mouse.x, mouse.y)
                                               var dy = xyInMosaicArea.y - mosaicArea.startMouseY
                                               mosaicArea.height = Math.max(1, mosaicArea.startH + dy)
                                               mosaicArea.y      = mosaicArea.fixedOppY
                                           }
                    }
                }

                // 左上コーナー
                Rectangle {
                    x: 0; y: 0
                    width: mosaicArea.handleSize; height: mosaicArea.handleSize
                    color: "transparent"
                    MouseArea {
                        id: tlHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeFDiagCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       var xyInMosaicArea = mosaicArea.mapFromItem(tlHandle, mouse.x, mouse.y)
                                       mosaicArea.startMouseX = xyInMosaicArea.x
                                       mosaicArea.startMouseY = xyInMosaicArea.y
                                       mosaicArea.startX      = mosaicArea.x
                                       mosaicArea.startY      = mosaicArea.y
                                       mosaicArea.startW      = mosaicArea.width
                                       mosaicArea.startH      = mosaicArea.height
                                       mosaicArea.fixedOppX   = mosaicArea.x + mosaicArea.width
                                       mosaicArea.fixedOppY   = mosaicArea.y + mosaicArea.height
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(tlHandle, mouse.x, mouse.y)
                                               var dx = xyInMosaicArea.x - mosaicArea.startMouseX
                                               var dy = xyInMosaicArea.y - mosaicArea.startMouseY
                                               mosaicArea.x      = mosaicArea.startX + dx
                                               mosaicArea.y      = mosaicArea.startY + dy
                                               mosaicArea.width  = mosaicArea.fixedOppX - mosaicArea.x
                                               mosaicArea.height = mosaicArea.fixedOppY - mosaicArea.y
                                           }
                    }
                }

                // 右上コーナー
                Rectangle {
                    x: mosaicArea.width - mosaicArea.handleSize; y: 0
                    width: mosaicArea.handleSize; height: mosaicArea.handleSize
                    color: "transparent"
                    MouseArea {
                        id: trHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeBDiagCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       var xyInMosaicArea = mosaicArea.mapFromItem(trHandle, mouse.x, mouse.y)
                                       mosaicArea.startMouseX = xyInMosaicArea.x
                                       mosaicArea.startMouseY = xyInMosaicArea.y
                                       mosaicArea.startX      = mosaicArea.x
                                       mosaicArea.startY      = mosaicArea.y
                                       mosaicArea.startW      = mosaicArea.width
                                       mosaicArea.startH      = mosaicArea.height
                                       mosaicArea.fixedOppX   = mosaicArea.x
                                       mosaicArea.fixedOppY   = mosaicArea.y + mosaicArea.height
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(trHandle, mouse.x, mouse.y)
                                               var dx = xyInMosaicArea.x - mosaicArea.startMouseX
                                               var dy = xyInMosaicArea.y - mosaicArea.startMouseY
                                               mosaicArea.y      = mosaicArea.startY + dy
                                               mosaicArea.width  = mosaicArea.startW + dx
                                               mosaicArea.height = mosaicArea.fixedOppY - mosaicArea.y
                                           }
                    }
                }

                // 左下コーナー
                Rectangle {
                    x: 0; y: mosaicArea.height - mosaicArea.handleSize
                    width: mosaicArea.handleSize; height: mosaicArea.handleSize
                    color: "transparent"
                    MouseArea {
                        id: blHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeBDiagCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       var xyInMosaicArea = mosaicArea.mapFromItem(blHandle, mouse.x, mouse.y)
                                       mosaicArea.startMouseX = xyInMosaicArea.x
                                       mosaicArea.startMouseY = xyInMosaicArea.y
                                       mosaicArea.startX      = mosaicArea.x
                                       mosaicArea.startY      = mosaicArea.y
                                       mosaicArea.startW      = mosaicArea.width
                                       mosaicArea.startH      = mosaicArea.height
                                       mosaicArea.fixedOppX   = mosaicArea.x + mosaicArea.width
                                       mosaicArea.fixedOppY   = mosaicArea.y
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(blHandle, mouse.x, mouse.y)
                                               var dx = xyInMosaicArea.x - mosaicArea.startMouseX
                                               var dy = xyInMosaicArea.y - mosaicArea.startMouseY
                                               mosaicArea.x      = mosaicArea.startX + dx
                                               mosaicArea.width  = mosaicArea.fixedOppX - mosaicArea.x
                                               mosaicArea.height = mosaicArea.startH + dy
                                           }
                    }
                }

                // 右下コーナー
                Rectangle {
                    x: mosaicArea.width - mosaicArea.handleSize
                    y: mosaicArea.height - mosaicArea.handleSize
                    width: mosaicArea.handleSize; height: mosaicArea.handleSize
                    color: "transparent"
                    MouseArea {
                        id: brHandle
                        anchors.fill: parent
                        cursorShape: Qt.SizeFDiagCursor
                        preventStealing: true
                        onPressed: mouse => {
                                       mouse.accepted = true
                                       var xyInMosaicArea = mosaicArea.mapFromItem(brHandle, mouse.x, mouse.y)
                                       mosaicArea.startMouseX = xyInMosaicArea.x
                                       mosaicArea.startMouseY = xyInMosaicArea.y
                                       mosaicArea.startX      = mosaicArea.x
                                       mosaicArea.startY      = mosaicArea.y
                                       mosaicArea.startW      = mosaicArea.width
                                       mosaicArea.startH      = mosaicArea.height
                                       mosaicArea.fixedOppX   = mosaicArea.x
                                       mosaicArea.fixedOppY   = mosaicArea.y
                                   }
                        onPositionChanged: mouse => {
                                               var xyInMosaicArea = mosaicArea.mapFromItem(brHandle, mouse.x, mouse.y)
                                               var dx = xyInMosaicArea.x - mosaicArea.startMouseX
                                               var dy = xyInMosaicArea.y - mosaicArea.startMouseY
                                               mosaicArea.width  = mosaicArea.startW + dx
                                               mosaicArea.height = mosaicArea.startH + dy
                                               mosaicArea.x      = mosaicArea.fixedOppX
                                               mosaicArea.y      = mosaicArea.fixedOppY
                                           }
                    }
                }
            }

            Row {
                spacing: 8
                Text {
                    text: "Mozaic Pixel Size"
                    color: "white"
                }
                Slider {
                    from: 1; to: 100; stepSize: 1
                    value: mosaicArea.blockSize
                    onMoved: mosaicArea.blockSize = value
                }
                Text {
                    text: mosaicArea.blockSize.toFixed(2)
                    color: "white"
                }
            }
        }
    }

    Component {
        id: distortionEffectImage

        Item {
            width: sourceImage.width
            height: sourceImage.height
            Image {
                id: sourceImage
                source: root.imageUrl
                visible: false
            }

            BulgeEffect {
                id: bulgeEffect
                sourceTexture: sourceImage
                width: sourceImage.width
                height: sourceImage.height

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPositionChanged: mouse => {
                                           bulgeEffect.u_center = Qt.vector2d(
                                               mouse.x / bulgeEffect.width,
                                               mouse.y / bulgeEffect.height
                                               )
                                       }
                }

                Column {
                    Row {
                        spacing: 8
                        Text {
                            text: "Radius"
                            color: "white"
                        }
                        Slider {
                            from: -2.0; to: 2.0; stepSize: 0.1
                            value: bulgeEffect.u_radius
                            onMoved: bulgeEffect.u_radius = value
                        }
                        Text {
                            text: bulgeEffect.u_radius.toFixed(2)
                            color: "white"
                        }
                    }
                    Row {
                        spacing: 8
                        Text {
                            text: "Strength"
                            color: "white"
                        }
                        Slider {
                            from: -10.0; to: 10.0; stepSize: 0.1
                            value: bulgeEffect.u_strength
                            onMoved: bulgeEffect.u_strength = value
                        }
                        Text {
                            text: bulgeEffect.u_strength.toFixed(2)
                            color: "white"
                        }
                    }
                }
            }
        }
    }

    Component {
        id: chromaticAberrationImage

        Item {
            width: sourceImage.width
            height: sourceImage.height
            Image {
                id: sourceImage
                source: root.imageUrl
                visible: false
            }

            ChromaticAberration {
                id: chromaticAberration
                width: sourceImage.width
                height: sourceImage.height
                sourceTexture: sourceImage
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPositionChanged: mouse => {
                                           chromaticAberration.u_focusPoint = Qt.vector2d(
                                               mouse.x / chromaticAberration.width,
                                               mouse.y / chromaticAberration.height
                                               )
                                       }
                }
            }

            Column {
                Row {
                    spacing: 8
                    Text {
                        text: "red offset"
                        color: "white"
                    }
                    Slider {
                        from: -0.01; to: 0.01; stepSize: 0.001
                        value: chromaticAberration.u_redOffset
                        onMoved: chromaticAberration.u_redOffset = value
                    }
                    Text {
                        text: chromaticAberration.u_redOffset.toFixed(2)
                        color: "white"
                    }
                }
                Row {
                    spacing: 8
                    Text {
                        text: "green offset"
                        color: "white"
                    }
                    Slider {
                        from: -0.01; to: 0.01; stepSize: 0.001
                        value: chromaticAberration.u_greenOffset
                        onMoved: chromaticAberration.u_greenOffset = value
                    }
                    Text {
                        text: chromaticAberration.u_greenOffset.toFixed(2)
                        color: "white"
                    }
                }
                Row {
                    spacing: 8
                    Text {
                        text: "blue offset"
                        color: "white"
                    }
                    Slider {
                        from: -0.01; to: 0.01; stepSize: 0.001
                        value: chromaticAberration.u_blueOffset
                        onMoved: chromaticAberration.u_blueOffset = value
                    }
                    Text {
                        text: chromaticAberration.u_blueOffset.toFixed(2)
                        color: "white"
                    }
                }
            }
        }
    }

    Component {
        id: radialBlurImage

        Item {
            width: sourceImage.width
            height: sourceImage.height
            Image {
                id: sourceImage
                source: root.imageUrl
                visible: false
            }
            RadialBlur {
                id: radialBlur
                anchors.fill: parent
                sourceTexture: sourceImage

                MouseArea {
                    anchors.fill: parent
                    onClicked: mouse => {
                        radialBlur.u_center = Qt.vector2d(
                            mouse.x / radialBlur.width,
                            mouse.y / radialBlur.height
                            )
                    }
                }

                Column {
                    spacing: 8
                    Row {
                        spacing: 8
                        Text {
                            text: "sample count"
                            color: "white"
                        }
                        Slider {
                            from: 1; to: 100; stepSize: 1
                            value: radialBlur.u_sampleCount
                            onMoved: radialBlur.u_sampleCount = value
                        }
                        Text {
                            text: radialBlur.u_sampleCount.toFixed(2)
                            color: "white"
                        }
                    }
                    Row {
                        spacing: 8
                        Text {
                            text: "strength"
                            color: "white"
                        }
                        Slider {
                            from: 0; to: 0.05; stepSize: 0.0001
                            value: radialBlur.u_strength
                            onMoved: radialBlur.u_strength = value
                        }
                        Text {
                            text: radialBlur.u_strength.toFixed(2)
                            color: "white"
                        }
                    }
                }
            }
        }
    }

    Component {
        id: vignetteEffectImage

        Item {
            width: sourceImage.width
            height: sourceImage.height
            Image {
                id: sourceImage
                source: root.imageUrl
                visible: false
            }

            VignetteEffect {
                id: vignetteEffect
                width: sourceImage.width
                height: sourceImage.height
                sourceTexture: sourceImage

                MouseArea {
                    anchors.fill: parent
                    onClicked: mouse => {
                        vignetteEffect.u_center = Qt.vector2d(
                            mouse.x / vignetteEffect.width,
                            mouse.y / vignetteEffect.height
                            )
                    }
                }
            }

            Column {
                spacing: 8
                Row {
                    spacing: 8
                    Text {
                        text: "fall off"
                        color: "white"
                    }
                    Slider {
                        from: 0.0; to: 1.0; stepSize: 0.01
                        value: vignetteEffect.u_falloff
                        onMoved: vignetteEffect.u_falloff = value
                    }
                    Text {
                        text: vignetteEffect.u_falloff.toFixed(2)
                        color: "white"
                    }
                }
                Row {
                    spacing: 8
                    Text {
                        text: "amount"
                        color: "white"
                    }
                    Slider {
                        from: 0.0; to: 1.0; stepSize: 0.01
                        value: vignetteEffect.u_amount
                        onMoved: vignetteEffect.u_amount = value
                    }
                    Text {
                        text: vignetteEffect.u_amount.toFixed(2)
                        color: "white"
                    }
                }
                Row {
                    spacing: 8
                    Text {
                        text: "radius"
                        color: "white"
                    }
                    Slider {
                        from: 0.0; to: 1.0; stepSize: 0.01
                        value: vignetteEffect.u_radius
                        onMoved: vignetteEffect.u_radius = value
                    }
                    Text {
                        text: vignetteEffect.u_radius.toFixed(2)
                        color: "white"
                    }
                }
            }
        }
    }
}
