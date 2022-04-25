import QtQuick 2.0
import Box2D 2.0
import Clayground.Physics 1.0

RectBoxBody
{
    bodyType: Body.Dynamic
    color: "#7084aa"
    categories: Box.Category1
    collidesWith: Box.Category2 | Box.Category3
    property int velocity: 10
    linearVelocity.x: velocity
    linearVelocity.y: 0
    sensor: true
    Timer{
        interval: 10; running: true; repeat: true
        onTriggered: {
            linearVelocity.x=velocity*2
                        if(x>theWorld.width) x=-width

        }
    }
}
