import QtQuick

ShaderEffect {
    id: root
    fragmentShader: "qrc:/RippleEffect.frag.qsb"

    property var rippleCenter1: Qt.vector2d(0, 0)
    property real rippleTime1: 0.0

    property var rippleCenter2: Qt.vector2d(0, 0)
    property real rippleTime2: 0.0

    property var rippleCenter3: Qt.vector2d(0, 0)
    property real rippleTime3: 0.0

    property var rippleCenter4: Qt.vector2d(0, 0)
    property real rippleTime4: 0.0

    property var rippleCenter5: Qt.vector2d(0, 0)
    property real rippleTime5: 0.0

    property int currentRippleIndex: 0

    NumberAnimation {
        id: rippleTime1Anim
        target: root
        property: "rippleTime1"
        duration: 5000
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCirc
    }

    NumberAnimation {
        id: rippleTime2Anim
        target: root
        property: "rippleTime2"
        duration: 5000
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCirc
    }

    NumberAnimation {
        id: rippleTime3Anim
        target: root
        property: "rippleTime3"
        duration: 5000
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCirc
    }

    NumberAnimation {
        id: rippleTime4Anim
        target: root
        property: "rippleTime4"
        duration: 5000
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCirc
    }

    NumberAnimation {
        id: rippleTime5Anim
        target: root
        property: "rippleTime5"
        duration: 5000
        from: 0.0
        to: 1.0
        easing.type: Easing.OutCirc
    }

    required property var source

    function addRipple(x: real, y: real) {
        switch(root.currentRippleIndex) {
        case 0:
            rippleCenter1 = Qt.vector2d(x, y)
            rippleTime1Anim.restart()
            break
        case 1:
            rippleCenter2 = Qt.vector2d(x, y)
            rippleTime2Anim.restart()
            break
        case 2:
            rippleCenter3 = Qt.vector2d(x, y)
            rippleTime3Anim.restart()
            break
        case 3:
            rippleCenter4 = Qt.vector2d(x, y)
            rippleTime4Anim.restart()
            break
        case 4:
            rippleCenter5 = Qt.vector2d(x, y)
            rippleTime5Anim.restart()
            break
        default:
            console.log("Ripple limit reached")
            return
        }
        root.currentRippleIndex = (root.currentRippleIndex + 1) % 5
    }
}
