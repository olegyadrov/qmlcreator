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

Loader {
    id: dialogLoader

    visible: status === Loader.Loading || status === Loader.Ready

    property var parameters
    property var callback

    property alias types: dialogTypes

    QtObject {
        id: dialogTypes

        property string message: "MessageDialog.qml"
        property string confirmation: "ConfirmationDialog.qml"
        property string list: "ListDialog.qml"
        property string fontFamily: "FontFamilyDialog.qml"
        property string fontSize: "FontSizeDialog.qml"
        property string indentSize: "IndentSizeDialog.qml"
        property string debugOverlayOpacity: "DebugOverlayOpacityDialog.qml"
        property string newFile: "NewFileDialog.qml"
        property string newProject: "NewProjectDialog.qml"
    }

    function open(type, parameters, callback) {
        dialogLoader.parameters = parameters
        dialogLoader.callback = callback
        dialogLoader.source = type
    }

    function close() {
        source = ""
    }

    onLoaded:
        item.initialize(parameters)

    Connections {
        target: item

        onProcess: {
            dialogLoader.source = ""
            dialogLoader.callback(value)
        }

        onClose: {
            dialogLoader.source = ""
        }
    }
}
