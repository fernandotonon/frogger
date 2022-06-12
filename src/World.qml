// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

                    // How to restart the game, or the level?
import QtQuick 2.12
import Box2D 2.0
import Clayground.GameController 1.0
import Clayground.World 1.0
import Clayground.Physics 1.0


ClayWorld {
    id: theWorld
    map: "map.svg"
    pixelPerUnit: width / theWorld.worldXMax
    gravity: Qt.point(0,0)
    timeStep: 1/60.0
    anchors.fill: parent
    physicsDebugging: false
    property var target: null
    property bool isCollidingWithWater: false

    components: new Map([
                         ['Player', c1],
                         ['Log', c2],
                            ['Wall', c3],
                            ['Water', c4],
                            ['Grass', c5]
                     ])
    Component { id: c1; Player {} }
    Component { id: c2; Log {} }
    Component { id: c3; Wall {} }
    Component { id: c4; RectBoxBody {
            color: "blue"
            bodyType: Body.Static
            categories: Box.Category4
            visible: !physicsDebugging
            }
        }
    Component { id: c5; RectBoxBody {
            color: "green"
            enabled: false
            sensor: true
            bodyType: Body.Static
            categories: Box.Category5
            visible: !physicsDebugging

            // street corner
            Rectangle {
                width: parent.width
                height: parent.height / 5
                color: "white"
            }
        } }

    property var player: null
    onMapAboutToBeLoaded: player = null;
    onMapLoaded: {
        theGameCtrl.selectKeyboard(Qt.Key_Up,
                                   Qt.Key_Down,
                                   Qt.Key_Left,
                                   Qt.Key_Right,
                                   Qt.Key_S,
                                   Qt.Key_A);
        theWorld.observedItem = player;
    }
    Keys.forwardTo: theGameCtrl
    GameController {
        id: theGameCtrl; anchors.fill: parent
        onButtonAPressedChanged: {
            if(buttonAPressed){
                if(target){
                    player.y = target.y
                    player.logVelocity = target.linearVelocity.x
                } else {
                    player.logVelocity = 0
                    if(isCollidingWithWater){
                        // player is on the water
                        player.color = "red"
                        theWorld.map = "";
                        theWorld.map = "map.svg";
                        gameApp.reset()
                    }
                }
            }
        }
    }

    CollisionTracker{
        id: theCollisionTracker
        onBeginContact: (entity)=>{
            target=entity
            entity.color='green'
        }
        onEndContact: {
            target=null
            entity.color='grey'
        }

    }
    CollisionTracker{
        id: waterCollisionTracker
        onBeginContact: {
            isCollidingWithWater = true
        }
        onEndContact: {
            isCollidingWithWater = false
        }

    }
    Component {
        id: collisionBox
        Box {
            y:-height*3
            width: 10
            height: 10
            sensor: true
            categories: Box.Category3
            collidesWith: Box.Category1
        }
    }



    onMapEntityCreated: (obj) => {
        if (obj instanceof Player) {
            player = obj;
            player.color = "#d45500";

            player.body.addFixture(collisionBox.createObject(player,{}));
            player.body.addFixture(collisionBox.createObject(player,{collidesWith: Box.Category4}));

            theCollisionTracker.fixture = player.fixtures[1];
            waterCollisionTracker.fixture = player.fixtures[2];
        }
    }

}
