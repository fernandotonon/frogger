import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: gameApp

    anchors.fill: parent
    color: "black"
    StackView{
        id: stack
        anchors.fill: parent
    }
    Component.onCompleted: stack.push(worldComp)

    Component {id: worldComp; World{}}

    function reset(){
        stack.pop()
        stack.push(worldComp)
    }
}
