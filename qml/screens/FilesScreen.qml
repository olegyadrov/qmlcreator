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
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import ProjectManager 1.1
import "../components"

BlankScreen {
    id: projectsScreen

    Stack.onStatusChanged: {
        if (Stack.status === Stack.Activating)
            listView.model = ProjectManager.files()
    }

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
                text: ProjectManager.projectName
            }

            CToolButton {
                Layout.fillHeight: true
                icon: "\uf067"
                tooltipText: qsTr("New file")
                onClicked: {
                    var parameters = {
                        title: qsTr("New file")
                    }

                    var callback = function(value)
                    {
                        ProjectManager.createFile(value.fileName, value.fileExtension)
                        listView.model = ProjectManager.files()
                    }

                    dialog.open(dialog.types.newFile, parameters, callback)
                }
            }
        }
    }

    CListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom

        delegate: CFileButton {
            text: modelData
            removeButtonVisible: modelData !== "main.qml"

            onClicked: {
                ProjectManager.fileName = modelData
                stackView.push(Qt.resolvedUrl("EditorScreen.qml"))
            }

            onRemoveClicked: {
                var parameters = {
                    title: qsTr("Delete the file"),
                    text: qsTr("Are you sure you want to delete \"%1\"?").arg(modelData)
                }

                var callback = function(value)
                {
                    if (value)
                    {
                        ProjectManager.removeFile(modelData)
                        listView.model = ProjectManager.files()
                    }
                }

                dialog.open(dialog.types.confirmation, parameters, callback)
            }
        }
    }
}
