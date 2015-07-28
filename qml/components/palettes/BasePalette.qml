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

QtObject {
    id: basePalette

    property color background: "#eeeeee"

    property color toolBarBackground: "#ffffff"
    property color toolBarStripe: "#aaaaaa"
    property color toolBarShadowBegin: "#30000000"
    property color toolBarShadowEnd: "#00000000"

    property color label: "#000000"
    property color description: "#222222"
    property color icon: "#000000"
    property color warning: "#ff0000"
    property color link: "#777777"

    property color textFieldBackground: "#ffffff"
    property color textFieldBorder: "#cccccc"
    property color textFieldPlaceholder: "#aaaaaa"
    property color textFieldSelection: "#aaaaaa"

    property color button: "#aaaaaa"

    property color separator: "#cccccc"

    property color scrollBar: "#30000000"

    property color dialogOverlay: "#30000000"
    property color dialogBackground: "#ffffff"
    property color dialogShadow: "#ff000000"

    property color sliderFilledStripe: "#000000";
    property color sliderEmptyStripe: "#aaaaaa";
    property color sliderHandle: "#ffffff"
    property color sliderHandleBorder: "#555555"

    property color tooltipBackground: "#cc000000"
    property color tooltipText: "#ffffff"

    property color switcherBackground: "#ffffff"
    property color switcherBorder: "#cccccc"
    property color switcherHandle: "#dddddd"

    property color contextMenuButton: "#cc000000"
    property color contextMenuButtonPressed: "#ff000000"
    property color contextMenuButtonText: "#ffffff"

    property color lineNumbersBackground:"#dddddd"
    property color lineNumber: "#aaaaaa"

    property color editorSelection: "#aaaaaa"
    property color editorSelectedText: "#ffffff"

    property color editorSelectionHandle: "#777777"

    property color editorNormal: "#000000"
    property color editorComment: "#008000"
    property color editorNumber: "#000080"
    property color editorString: "#008000"
    property color editorOperator: "#000000"
    property color editorKeyword: "#808000"
    property color editorBuiltIn: "#0055af"
    property color editorMarker: "#ffff00"
    property color editorItem: "#800080"
    property color editorProperty: "#800000"
}
