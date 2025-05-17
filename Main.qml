import QtQuick
import QtQuick.Controls

import ShaderEffects

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ListView {
        anchors.fill: parent

        model: [
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
                source: "qrc:/qt/qml/ShaderEffectsQMLPlayground/images/Mount_Kirkjufell_Iceland.jpg"
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
                source: "qrc:/qt/qml/ShaderEffectsQMLPlayground/images/Mount_Kirkjufell_Iceland.jpg"
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

            source: "qrc:/qt/qml/ShaderEffectsQMLPlayground/images/Mount_Kirkjufell_Iceland.jpg"
        }
    }

    Component {
        id: godRaysComponent

        GodRaysEffect {
            id: godrayEffect
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
            source: "qrc:/qt/qml/ShaderEffectsQMLPlayground/images/Mount_Kirkjufell_Iceland.jpg"

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

}
