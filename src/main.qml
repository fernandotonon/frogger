// (c) serein.pfeiffer@gmail.com - zlib license, see "LICENSE" file

import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    visibility: Window.Maximized
    title: qsTr("Frogger")
    Sandbox { anchors.centerIn: parent }
    Component.onCompleted: if(Qt.platform.pluginName === "minimal") Qt.quit()
}
