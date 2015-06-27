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
import QtQuick.Controls.Styles 1.3
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import "palettes"

ApplicationWindow {
    id: cApplicationWindow
    width: 420
    height: 640
    visible: true
    title: "QML Creator"
    visibility: settings.debugMode ? "FullScreen" : "Maximized"

    style: ApplicationWindowStyle {
        background: Rectangle {
            color: palette.background
        }
    }

    // Loading
    signal loaded()

    Component.onCompleted:
        loaded()

    onLoaded: {
        // http://doc.qt.io/qt-5/qml-qtquick-window-screen.html
        // The Screen attached object is valid inside Item or Item derived types, after component completion
        settings.pixelDensity = settings.debugMode ? 6.0 : Screen.logicalPixelDensity

        if (settings.firstRun)
        {
            projectManager.restoreExamples()
            settings.firstRun = false
        }
    }

    // Settings
    QtObject {
        id: settings

        // configurable
        property string font: "Ubuntu Mono"
        property int fontSize: 40
        property string palette: "Cute"
        property int indentSize: 4

        // internal
        property bool debugMode: false
        property double pixelDensity
        property bool firstRun: true
        property bool desktopPlatform: Qt.platform.os === "windows" ||
                                       Qt.platform.os === "linux" ||
                                       Qt.platform.os === "osx" ||
                                       Qt.platform.os === "unix"
    }

    Settings {
        category: "Editor"
        property alias font: settings.font
        property alias fontSize: settings.fontSize
        property alias palette: settings.palette
        property alias indentSize: settings.indentSize
        property alias firstRun: settings.firstRun
    }

    property alias settings: settings

    // Palettes

    PaletteLoader {
        id: paletteLoader
        name: settings.palette
    }

    property alias palette: paletteLoader.palette

    // Focus Management

    property var focusItem: null
    signal backPressed()

    onActiveFocusItemChanged: {
        if (focusItem !== null && focusItem.Keys !== undefined)
            focusItem.Keys.onReleased.disconnect(onKeyReleased)

        if (activeFocusItem !== null)
        {
            activeFocusItem.Keys.onReleased.connect(onKeyReleased)
            focusItem = activeFocusItem
        }
    }

    function onKeyReleased(event) {
        if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) {
            if (Qt.inputMethod.visible)
                Qt.inputMethod.hide()
            else
                backPressed()

            event.accepted = true
        }
    }

    property ListModel editorFonts: ListModel {
        ListElement {
            name: "Ubuntu Mono"
            source: "../../resources/fonts/editor/ubuntumono.ttf"
        }

        ListElement {
            name: "DejaVu Sans Mono"
            source: "../../resources/fonts/editor/dejavusansmono.ttf"
        }

        ListElement {
            name: "Liberation Mono"
            source: "../../resources/fonts/editor/liberationmono.ttf"
        }

        ListElement {
            name: "Droid Sans Mono"
            source: "../../resources/fonts/editor/droidsansmono.ttf"
        }

        ListElement {
            name: "Fira Mono"
            source: "../../resources/fonts/editor/firamono.ttf"
        }

        ListElement {
            name: "Source Code Pro"
            source: "../../resources/fonts/editor/sourcecodepro.ttf"
        }

        function getCurrentIndex() {
            for (var i = 0; i < count; i++)
            {
                if (get(i).name === settings.font)
                    return i;
            }

            return -1;
        }
    }

    Repeater {
        model: editorFonts
        delegate: Loader {
            sourceComponent: FontLoader {
                source: model.source
            }
        }
    }

    // UI Fonts

    FontLoader {
        source: "../../resources/fonts/ui/robotoregular.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/robotoitalic.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/robotobold.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/robotobolditalic.ttf"
    }

    FontLoader {
        source: "../../resources/fonts/ui/fontawesome.ttf"
    }
}
