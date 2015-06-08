/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 1.3
import "../components"

BlankScreen {
    id: modulesScreen

    CToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        CBackButton {
            anchors.fill: parent
            text: qsTr("Modules")
        }
    }

    CTextArea {
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        text:  textStyle() +
               "The modules you can use in the current QML Creator release:<br><br>
                 > Qt.WebSockets 1.0<br>
                 > Qt.labs.folderlistmodel 2.1<br>
                 > Qt.labs.settings 1.0<br>
                 > QtAudioEngine 1.0<br>
                 > QtBluetooth 5.2<br>
                 > QtGraphicalEffects 1.0<br>
                 > QtLocation 5.3<br>
                 > QtMultimedia 5.4<br>
                 > QtNfc 5.2<br>
                 > QtPositioning 5.2<br>
                 > QtQml 2.2<br>
                 > QtQml.Models 2.1<br>
                 > QtQuick 2.4<br>
                 > QtQuick.Controls 1.3<br>
                 > QtQuick.Controls.Styles 1.3<br>
                 > QtQuick.Dialogs 1.2<br>
                 > QtQuick.Layouts 1.1<br>
                 > QtQuick.LocalStorage 2.0<br>
                 > QtQuick.Particles 2.0<br>
                 > QtQuick.Window 2.2<br>
                 > QtQuick.XmlListModel 2.0<br>
                 > QtSensors 5.0<br>
                 > QtTest 1.1"
    }
}
