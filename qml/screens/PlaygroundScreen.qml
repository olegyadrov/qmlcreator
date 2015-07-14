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
import QtQuick.Layouts 1.1
import "../components"

BlankScreen {
    id: playgroundScreen
    enabled: true

    CToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        CBackButton {
            anchors.fill: parent
            enabled: !stackView.busy
            text: projectManager.fileName
        }
    }

    Item {
        id: playArea
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true

        CLabel {
            id: errorLabel
            anchors.fill: parent
            anchors.margins: 10
            wrapMode: Text.Wrap
            visible: false
        }
    }

    Component.onCompleted: {
        var componentUrl = projectManager.getFilePath()
        var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, playgroundScreen)
        if (playComponent.status === Component.Error)
        {
            errorLabel.text = playComponent.errorString()
            errorLabel.visible = true
        }
        else
        {
            playComponent.createObject(playArea)
        }
    }
}
