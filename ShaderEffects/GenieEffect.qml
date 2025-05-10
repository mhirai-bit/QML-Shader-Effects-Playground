import QtQuick

ShaderEffect {
    id: root
    vertexShader: "qrc:/GenieEffect.vert.qsb"
    mesh: GridMesh { resolution: Qt.size(32, 32) }

    required property var source
    property bool minimized: false
    property real minimize: 0.0
    property real bend: 0.0
    property real side: 1.0

    ParallelAnimation {
        id: animMinimize
        running: root.minimized
        SequentialAnimation  {
            PauseAnimation { duration: 200 }
            NumberAnimation {
                target: root; property: "minimize"
                to: 1.0
                duration: 700
                easing.type: Easing.InOutSine
            }
            PauseAnimation { duration: 1000 }
        }
        SequentialAnimation {
            NumberAnimation {
                target: root; property: "bend"
                to: 1.0; duration: 400
                easing.type: Easing.InOutSine
            }
            PauseAnimation { duration: 1300 }
        }
    }

    ParallelAnimation {
            id: animNormalize
            running: !root.minimized
            SequentialAnimation {
                NumberAnimation {
                    target: root; property: 'minimize';
                    to: 0; duration: 700;
                    easing.type: Easing.InOutSine
                }
                PauseAnimation { duration: 1300 }
            }
            SequentialAnimation {
                PauseAnimation { duration: 300 }
                NumberAnimation {
                    target: root; property: 'bend'
                    to: 0; duration: 700;
                    easing.type: Easing.InOutSine }
                PauseAnimation { duration: 1000 }
            }
        }
}
