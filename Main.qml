import QtQuick
import QtQuick.Controls

import ShaderEffects

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    SwipeView {
        anchors.fill: parent
        GenieEffect {
            width: 500; height: width
        }
    }
}
