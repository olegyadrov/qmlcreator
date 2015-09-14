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

import QtQuick 2.5
import QtQuick.Layouts 1.2
import ProjectManager 1.1
import "../components"

BlankScreen {
    id: playgroundScreen
    enabled: true

    CToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        RowLayout {
            anchors.fill: parent
            spacing: 0

            CBackButton {
                Layout.fillWidth: true
                Layout.fillHeight: true
                enabled: !stackView.busy
                text: ProjectManager.fileName
            }

            CToolButton {
                Layout.fillHeight: true
                icon: "\uf188"
                tooltipText: settings.debugging ? qsTr("Disable debugging") : qsTr("Enable debugging")
                checked: settings.debugging
                onClicked: {
                    settings.debugging = !settings.debugging
                }
            }
        }
    }

    Item {
        id: playArea
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true

        Flickable {
            id: messagesFlickable
            z: 2
            anchors.fill: parent
            anchors.margins: 3 * settings.pixelDensity
            contentWidth: messages.paintedWidth
            contentHeight: messages.paintedHeight
            enabled: false

            function scrollDown() {
                if (contentHeight > height)
                    contentY = contentHeight - height
            }

            TextEdit {
                id: messages
                width: messagesFlickable.width
                height: messagesFlickable.height
                visible: settings.debugging
                color: palette.editorNormal
                opacity: 0.3
                font.pixelSize: 6 * settings.pixelDensity
                wrapMode: TextEdit.Wrap
                readOnly: true

                onTextChanged:
                    messagesFlickable.scrollDown()
            }
        }

        Connections {
            target: messageHandler
            onMessageReceived:
                messages.append(message)
        }
    }

    Component.onCompleted: {
        var componentUrl = ProjectManager.getFilePath()
        var playComponent = Qt.createComponent(componentUrl, Component.PreferSynchronous, playgroundScreen)
        if (playComponent.status === Component.Error)
        {
            messages.append(playComponent.errorString())
        }
        else
        {
            playComponent.createObject(playArea)
        }
    }
}
