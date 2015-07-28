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

BasePalette {
    id: darkPalette

    background: "#263238"

    toolBarBackground: "#384248"
    toolBarStripe: "#80cbc4"
    toolBarShadowBegin: "#45000000"
    toolBarShadowEnd: "#00000000"

    label: "#f3f3f3"
    description: "#cccccc"
    icon: "#f3f3f3"
    warning: "#bd3636"
    link: "#80cbc4"

    textFieldBackground: "#384248"
    textFieldBorder: "#485257"
    textFieldPlaceholder: "#aaaaaa"
    textFieldSelection: "#aaaaaa"

    button: "#687074"

    separator: "#485257"

    scrollBar: "#30ffffff"

    dialogOverlay: "#40ffffff"
    dialogBackground: "#263238"
    dialogShadow: "#aa000000"

    sliderFilledStripe: "#cccccc"
    sliderEmptyStripe: "#485257"
    sliderHandle: "#f3f3f3"
    sliderHandleBorder: "#687074"

    tooltipBackground: "#ee586973"
    tooltipText: "#ffffff"

    switcherBackground: "#384248"
    switcherBorder: "#485257"
    switcherHandle: "#59676e"

    contextMenuButton: "#ee586973"
    contextMenuButtonPressed: "#ff586973"
    contextMenuButtonText: "#ffffff"

    lineNumbersBackground:"#485257"
    lineNumber: "#aaaaaa"

    editorSelection: "#687074"
    editorSelectedText: "#ffffff"

    editorSelectionHandle: "#80cbc4"

    editorNormal: "#f3f3f3"
    editorComment: "#55ffff"
    editorNumber: "#c0c0c0"
    editorString: "#ff55ff"
    editorOperator: "#f3f3f3"
    editorKeyword: "#ffff55"
    editorBuiltIn: "#8888ff"
    editorMarker: "#ffff00"
    editorItem: "#55ff55"
    editorProperty: "#ff5555"
}
