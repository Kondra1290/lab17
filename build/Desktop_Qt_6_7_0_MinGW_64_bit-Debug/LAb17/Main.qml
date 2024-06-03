import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.qmlmodels
import QtQuick.Controls.Material
import ListModel

ApplicationWindow
{
    id: root
    width: 640
    height: 480
    visible: true

    Game {
        id: gameWindow
        visible: false
        onStopGame:{
            gameWindow.timeLeft = 7
            gameWindow.close()
            root.show()
        }
    }

    RowLayout{
        anchors.fill: parent
        spacing: 0
        Rectangle
        {
            color: '#03dffc'
            width:320
            height: 480

            Text
            {
                id: questionText
                font.pixelSize: 40
                text: ""
            }

            TextField {
                id: userName
                font.pixelSize: 14
                width: 150
                text: ""
                x: 85
                y: 150
                visible: true
            }

            Button
            {
                id: enterName
                width: 150
                height: 40
                text: "Начать игру"
                onClicked:
                {
                    if(userName.text !== "")
                    {
                        gameWindow.user = userName.text
                        userName.text = "";
                        //GL.generateQuestion()
                        gameWindow.show();
                        root.hide()
                    }
                    else{

                    }
                }
                anchors.centerIn: parent
                visible: root.visible
            }
        }

        Rectangle
        {
            width: 320
            height: 480
            color: "green"
            ColumnLayout
            {
                anchors.fill: parent
                anchors.margins: 0
                HorizontalHeaderView {
                    id: horizontalHeader
                    anchors.left: tableView.left
                    //anchors.top: parent.top
                    syncView: tableView
                    clip: true
                    model: ["Пользователь", "Рекорд"]
                }

                TableView
                {
                    id: tableView
                    anchors.left: parent.left
                    anchors.top: horizontalHeader.bottom
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    columnSpacing: 1
                    rowSpacing: 1
                    clip: true

                    property int selectedRow: -1
                    property int selectedId: -1

                    model: myModel

                    columnWidthProvider: function () { return parent.width/2}

                    delegate: ItemDelegate
                    {
                        highlighted: tableView.selectedRow != -1 && row == tableView.selectedRow
                        onClicked: {tableView.selectedRow = row; tableView.selectedId = id}
                        text: column == 0 ? id : column == 1 ? user : score
                        background:
                            Rectangle
                            {
                                color: highlighted ? palette.light : palette.window
                            }
                        palette.light: "skyblue"
                        palette.highlightedText: "black"
                        palette.text: "black"
                        palette.window: "lightgrey"
                    }
                }
            }
        }
    }
}
