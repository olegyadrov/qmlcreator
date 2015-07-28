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
import "../components"

BlankScreen {
    id: modulesScreen

    // http://doc.qt.io/qt-5/modules-qml.html
    ListModel {
        id: modules

        ListElement { module: "QtQml";                   version: ""; status: 0; testComponent: "Qml.qml" }
        ListElement { module: "QtQuick";                 version: ""; status: 0; testComponent: "Quick.qml" }
        ListElement { module: "QtQuick.Controls";        version: ""; status: 0; testComponent: "Controls.qml" }
        ListElement { module: "QtQuick.Controls.Styles"; version: ""; status: 0; testComponent: "Styles.qml" }
        ListElement { module: "QtQuick.Layouts";         version: ""; status: 0; testComponent: "Layouts.qml" }
        ListElement { module: "QtQml.Models";            version: ""; status: 0; testComponent: "Models.qml" }
        ListElement { module: "QtQuick.XmlListModel";    version: ""; status: 0; testComponent: "XmlListModel.qml" }
        ListElement { module: "QtQuick.LocalStorage";    version: ""; status: 0; testComponent: "LocalStorage.qml" }
        ListElement { module: "QtQuick.Particles";       version: ""; status: 0; testComponent: "Particles.qml" }
        ListElement { module: "QtQuick.Window";          version: ""; status: 0; testComponent: "Window.qml" }
        ListElement { module: "QtQuick.Dialogs";         version: ""; status: 0; testComponent: "Dialogs.qml" }
        ListElement { module: "QtTest";                  version: ""; status: 0; testComponent: "Test.qml" }
        ListElement { module: "QtGraphicalEffects";      version: ""; status: 0; testComponent: "GraphicalEffects.qml" }
        ListElement { module: "QtSensors";               version: ""; status: 0; testComponent: "Sensors.qml" }
        ListElement { module: "QtMultimedia";            version: ""; status: 0; testComponent: "Multimedia.qml" }
        ListElement { module: "QtAudioEngine";           version: ""; status: 0; testComponent: "AudioEngine.qml" }
        ListElement { module: "QtPositioning";           version: ""; status: 0; testComponent: "Positioning.qml" }
        ListElement { module: "QtBluetooth";             version: ""; status: 0; testComponent: "Bluetooth.qml" }
        ListElement { module: "QtNfc";                   version: ""; status: 0; testComponent: "Nfc.qml" }
        ListElement { module: "QtWebSockets";            version: ""; status: 0; testComponent: "WebSockets.qml" }
        ListElement { module: "QtWebView";               version: ""; status: 0; testComponent: "WebView.qml" }

        ListElement { module: "Qt3D";                    version: ""; status: 0; testComponent: "3D.qml" }
        ListElement { module: "Qt3D.Input";              version: ""; status: 0; testComponent: "3DInput.qml" }
        ListElement { module: "Qt3D.Renderer";           version: ""; status: 0; testComponent: "3DRenderer.qml" }
        ListElement { module: "QtQuick.Scene3D";         version: ""; status: 0; testComponent: "Scene3D.qml" }

        ListElement { module: "QtCanvas3D";              version: ""; status: 0; testComponent: "Canvas3D.qml" }
        ListElement { module: "QtLocation";              version: ""; status: 0; testComponent: "Location.qml" }
        ListElement { module: "Qt.labs.folderlistmodel"; version: ""; status: 0; testComponent: "FolderListModel.qml" }
        ListElement { module: "Qt.labs.settings";        version: ""; status: 0; testComponent: "Settings.qml" }
    }

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

    ListView {
        id: listView
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        model: modules

        delegate: CInformationItem {
            text: module + " " + version
            description: if (status === 1)
                             qsTr("Available")
                         else if (status === 2)
                             qsTr("Not available")
                         else
                             qsTr("Undefined")
            descriptionColor: if (status === 1)
                                  palette.description
                              else if (status === 2)
                                  palette.warning
                              else
                                  palette.label
        }
    }

    CScrollBar {
        flickableItem: listView
    }

    property int moduleId: 0

    Loader {
        id: loader
        asynchronous: true
        onStatusChanged: {
            if (status === Loader.Ready || status === Loader.Error)
            {
                var module = modules.get(moduleId)

                if (status === Loader.Ready)
                {
                    module.status = 1
                    module.version = item.version
                }
                else
                {
                    module.status = 2
                }

                if (++moduleId < modules.count)
                    loader.source = "../modules/" + modules.get(moduleId).testComponent
            }
        }
    }

    Component.onCompleted:
        loader.source = "../modules/" + modules.get(0).testComponent
}
