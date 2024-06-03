// НЕ ИСПОЛЬЗУЕТСЯ

import QtQuick 2.15
import QtQuick.Controls 2.15
import 'GameLogic.js' as GL

Window {
    id: gameOverScreen
    width: 640
    height: 480
    color: '#03dffc'
    visible: false
    signal restart

    Button {
        onClicked: {
            gameOverScreen.restart()
        }
        anchors.centerIn: parent
        //y: 265
        //x: 195
        visible: root.visible
        contentItem:
            Image
            {
                source: "qrc:/iconca.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }
    }
}
