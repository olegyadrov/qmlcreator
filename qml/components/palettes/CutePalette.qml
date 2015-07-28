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
    id: cutePalette

    background: "#f2f2f2"

    toolBarBackground: "#ffffff"
    toolBarStripe: "#80c342"
    toolBarShadowBegin: "#20000000"
    toolBarShadowEnd: "#00000000"

    label: "#1e1b18"
    description: "#006325"
    icon: "#1e1b18"
    warning: "#ff0000"
    link: "#006325"

    textFieldBackground: "#ffffff"
    textFieldBorder: "#ccddd5"
    textFieldPlaceholder: "#aaaaaa"
    textFieldSelection: "#aaaaaa"

    button: "#80c342"

    separator: "#ccddd5"

    scrollBar: "#30000000"

    dialogOverlay: "#30000000"
    dialogBackground: "#f2f2f2"
    dialogShadow: "#ff000000"

    sliderFilledStripe: "#80c342"
    sliderEmptyStripe: "#ccddd5"
    sliderHandle: "#ffffff"
    sliderHandleBorder: "#006325"

    tooltipBackground: "#cc222222"
    tooltipText: "#ffffff"

    switcherBackground: "#ffffff"
    switcherBorder: "#ccddd5"
    switcherHandle: "#80c342"

    contextMenuButton: "#cc222222"
    contextMenuButtonPressed: "#ff222222"
    contextMenuButtonText: "#ffffff"

    lineNumbersBackground:"#e8e8e8"
    lineNumber: "#999999"

    editorSelection: "#80c342"
    editorSelectedText: "#ffffff"

    editorSelectionHandle: "#006325"

    editorNormal: "#1e1b18"
    editorComment: "#008000"
    editorNumber: "#000080"
    editorString: "#008000"
    editorOperator: "#1e1b18"
    editorKeyword: "#808000"
    editorBuiltIn: "#0055af"
    editorMarker: "#ffff00"
    editorItem: "#800080"
    editorProperty: "#800000"
}
