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

        model: [genieEffectImage]

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
                    anchors.fill: parent

                    drag.target: button
                    drag.axis: Drag.XAxis
                    drag.minimumX: 0
                    drag.maximumX: screen.width - button.width

                    onClicked: {
                        genieEffect.side = (button.x + button.width/2)/screen.width
                        genieEffect.minimized = !genieEffect.minimized
                    }
                }
            }
        }
    }
}
