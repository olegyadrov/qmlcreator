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

    ListModel {
        id: modules

        ListElement { module: "QtQml";                   version: "2.2"; status: 0; testComponent: "Qml.qml" }
        ListElement { module: "QtQuick";                 version: "2.4"; status: 0; testComponent: "Quick.qml" }
        ListElement { module: "QtQuick.Controls";        version: "1.3"; status: 0; testComponent: "Controls.qml" }
        ListElement { module: "QtQuick.Controls.Styles"; version: "1.3"; status: 0; testComponent: "Styles.qml" }
        ListElement { module: "QtQuick.Layouts";         version: "1.1"; status: 0; testComponent: "Layouts.qml" }
        ListElement { module: "QtQml.Models";            version: "2.1"; status: 0; testComponent: "Models.qml" }
        ListElement { module: "QtQuick.XmlListModel";    version: "2.0"; status: 0; testComponent: "XmlListModel.qml" }
        ListElement { module: "QtQuick.LocalStorage";    version: "2.0"; status: 0; testComponent: "LocalStorage.qml" }
        ListElement { module: "QtQuick.Particles";       version: "2.0"; status: 0; testComponent: "Particles.qml" }
        ListElement { module: "QtQuick.Window";          version: "2.2"; status: 0; testComponent: "Window.qml" }
        ListElement { module: "QtQuick.Dialogs";         version: "1.2"; status: 0; testComponent: "Dialogs.qml" }
        ListElement { module: "QtTest";                  version: "1.1"; status: 0; testComponent: "Test.qml" }
        ListElement { module: "QtGraphicalEffects";      version: "1.0"; status: 0; testComponent: "GraphicalEffects.qml" }
        ListElement { module: "QtSensors";               version: "5.5"; status: 0; testComponent: "Sensors.qml" }
        ListElement { module: "QtMultimedia";            version: "5.4"; status: 0; testComponent: "Multimedia.qml" }
        ListElement { module: "QtAudioEngine";           version: "1.0"; status: 0; testComponent: "AudioEngine.qml" }
        ListElement { module: "QtPositioning";           version: "5.2"; status: 0; testComponent: "Positioning.qml" }
        ListElement { module: "QtBluetooth";             version: "5.2"; status: 0; testComponent: "Bluetooth.qml" }
        ListElement { module: "QtNfc";                   version: "5.2"; status: 0; testComponent: "Nfc.qml" }
        ListElement { module: "QtWebSockets";            version: "1.0"; status: 0; testComponent: "WebSockets.qml" }
        ListElement { module: "QtWebView";               version: "1.0"; status: 0; testComponent: "WebView.qml" }
        ListElement { module: "QtCanvas3D";              version: "1.0"; status: 0; testComponent: "Canvas3D.qml" }
        ListElement { module: "QtLocation";              version: "5.3"; status: 0; testComponent: "Location.qml" }
        ListElement { module: "Qt.labs.folderlistmodel"; version: "2.1"; status: 0; testComponent: "FolderListModel.qml" }
        ListElement { module: "Qt.labs.settings";        version: "1.0"; status: 0; testComponent: "Settings.qml" }
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
            descriptionColor: (status === 1) ? palette.description : palette.warning
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
            if (status === Loader.Ready || status === Loader.Error) {
                modules.get(moduleId).status = (status === Loader.Ready) ? 1 : 2

                if (++moduleId < modules.count)
                    loader.source = "../modules/" + modules.get(moduleId).testComponent
            }
        }
    }

    Component.onCompleted:
        loader.source = "../modules/" + modules.get(0).testComponent
}
