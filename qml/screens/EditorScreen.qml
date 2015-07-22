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
    id: editorScreen

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
                text: projectManager.fileName
            }

            CToolButton {
                visible: codeArea.selectedText.length > 0
                Layout.fillHeight: true
                icon: "\uf034"
                tooltipText: qsTr("Select all")
                onClicked: codeArea.selectAll()
            }

            CToolButton {
                visible: codeArea.selectedText.length > 0
                Layout.fillHeight: true
                icon: "\uf0c5"
                tooltipText: qsTr("Copy")
                onClicked: codeArea.copy()
            }

            CToolButton {
                visible: codeArea.selectedText.length > 0
                Layout.fillHeight: true
                icon: "\uf0c4"
                tooltipText: qsTr("Cut")
                onClicked: codeArea.cut()
            }

            CToolButton {
                visible: projectManager.fileFormat === "qml" && !codeArea.selectedText.length > 0
                Layout.fillHeight: true
                icon: "\uf04b"
                tooltipText: qsTr("Run")
                onClicked: {
                    projectManager.saveFileContent(codeArea.text)
                    projectManager.clearComponentCache()
                    Qt.inputMethod.hide()
                    stackView.push(Qt.resolvedUrl("PlaygroundScreen.qml"))
                }
            }
        }
    }

    CCodeArea {
        id: codeArea

        Component.onDestruction: {
            projectManager.saveFileContent(text)
        }

        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        indentSize: settings.indentSize

        text: projectManager.getFileContent()
    }
}
