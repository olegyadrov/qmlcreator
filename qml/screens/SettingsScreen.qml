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
    id: mainMenuScreen

    CToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        CBackButton {
            anchors.fill: parent
            text: qsTr("Settings")
        }
    }

    CFlickable {
        id: settingsFlickable
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        contentHeight: column.height

        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right

            CSettingButton {
                text: qsTr("Font family")
                description: settings.font
                onClicked: {
                    var parameters = {
                        title: "Editor font",
                        model: editorFonts,
                        currentIndex: editorFonts.getCurrentIndex()
                    }

                    var callback = function(value) {
                        settings.font = editorFonts.get(value).name
                    }

                    dialog.open(dialog.types.fontFamily, parameters, callback)
                }
            }

            CSettingButton {
                text: qsTr("Font size")
                description: settings.fontSize.toString() + " px"

                onClicked: {
                    var parameters = {
                        title: "Font size",
                        text: "Preview",
                        minSize: 20,
                        maxSize: 80,
                        currentSize: settings.fontSize
                    }

                    var callback = function(value) {
                        if (value < 1) return

                        if (value < parameters.minSize)
                            settings.fontSize = parameters.minSize;
                        else if (value > parameters.maxSize)
                            settings.fontSize = parameters.maxSize;
                        else
                            settings.fontSize = value;
                    }

                    dialog.open(dialog.types.fontSize, parameters, callback)
                }
            }

            CSettingButton {
                text: qsTr("Indent size")
                description: settings.indentSize.toString()

                onClicked: {
                    var parameters = {
                        title: "Indent size",
                        minSize: 0,
                        maxSize: 4,
                        currentSize: settings.indentSize
                    }

                    var callback = function(value) {
                        if (value < parameters.minSize)
                            settings.indentSize = parameters.minSize;
                        else if (value > parameters.maxSize)
                            settings.indentSize = parameters.maxSize;
                        else
                            settings.indentSize = value;
                    }

                    dialog.open(dialog.types.indentSize, parameters, callback)
                }
            }

            CSettingButton {
                text: qsTr("Palette")
                description: settings.palette
                onClicked: {
                    var parameters = {
                        title: "Palette",
                        model: palettes,
                        currentIndex: palettes.getCurrentIndex()
                    }

                    var callback = function(value) {
                        settings.palette = palettes.get(value).name
                    }

                    dialog.open(dialog.types.list, parameters, callback)
                }
            }
        }
    }

    CScrollBar {
        flickableItem: settingsFlickable
    }

    ListModel {
        id: palettes

        ListElement {
            name: "Cute"
            source: "CutePalette.qml"
        }

        ListElement {
            name: "Light"
            source: "LightPalette.qml"
        }

        ListElement {
            name: "Dark"
            source: "DarkPalette.qml"
        }

        function getCurrentIndex() {
            for (var i = 0; i < count; i++)
            {
                if (get(i).name === settings.palette)
                    return i;
            }

            return -1;
        }
    }
}
