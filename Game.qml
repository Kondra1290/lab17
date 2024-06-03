import QtQuick 2.15
import QtQuick.Controls 2.15
import 'GameLogic.js' as GL

Window {
    id: game
    visible: false
    width: 640
    height: 480
    title: "Math Game"
    signal stopGame

    property bool start: true
    property color startColor: "red"
    property color endColor: "blue"
    property int timeLeft: 7
    property int sc: GL.score
    property string user: ""

    Timer
    {
        id: timer
        interval: 1000
        repeat: true
        running: game.visible
        onTriggered:
        {
            timeLeft--;
            if ( timeLeft == 0) GL.gameOver()
        }
    }

    Text
    {
        id: timerText
        text: "Оставшееся время: " + timeLeft
        anchors.top: parent.top
        anchors.left: parent.left
        font.bold: true
        font.pointSize: 28
    }

    Text
    {
        text: "Счет: " +  sc
        font.pixelSize: 28
        font.bold: true
        anchors.top: parent.top
        anchors.right: parent.right
    }

    Column {
            spacing: 10
            anchors.centerIn: parent
            visible: true

            Text
            {
                id: questionText
                font.pixelSize: 40
                text: ""
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: questionText1
                font.pixelSize: 40
                width: questionText.width
                text: ""
                horizontalAlignment: Text.AlignHCenter
                visible: false
                validator: IntValidator {bottom: -100; top: 99}
                onAccepted:
                {
                    animation.stop()
                    game.color = 'white'
                    GL.checkAnswer(parseInt(questionText1.text))
                    questionText1.text = ''
                }
            }

            Button
            {
                id: button1
                text: "0"
                height: 50
                onClicked: GL.checkAnswer(0)
                width: questionText.width
                visible: true
            }

            Button
            {
                id: button2
                text: "1"
                height: 50
                onClicked: GL.checkAnswer(1)

                width: questionText.width
                visible: true
            }

            Button
            {
                id: button3
                text: "2"
                height: 50
                onClicked: GL.checkAnswer(2)
                width: questionText.width
                visible: true
            }

            Button
            {
                id: button4
                text: "3"
                height: 50
                onClicked: GL.checkAnswer(3)
                width: questionText.width
                visible: true
            }

            Button
            {
                text: "Перезагрузить"
                height: 50
                onClicked:
                {
                    GL.score = 0;
                    GL.points = 1;
                    GL.generateQuestion()
                    game.stopGame()
                }
                width: questionText.width
            }
    }

        SequentialAnimation
        {
            id: animation

            ColorAnimation
            {
                target: game
                property: "color"
                from: startColor
                to: endColor
                duration: 1000
            }

            ColorAnimation
            {
                target: game
                property: "color"
                from: endColor
                to: startColor
                duration: 1000
            }
            loops: Animation.Infinite
        }

        Component.onCompleted: GL.generateQuestion()
}
