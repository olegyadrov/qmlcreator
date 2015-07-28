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
    id: lightPalette

    background: "#f8f8f8"

    toolBarBackground: "#ffffff"
    toolBarStripe: "#167ffc"
    toolBarShadowBegin: "#30000000"
    toolBarShadowEnd: "#00000000"

    label: "#222222"
    description: "#777777"
    icon: "#222222"
    warning: "#ff0000"
    link: "#167ffc"

    textFieldBackground: "#ffffff"
    textFieldBorder: "#cccccc"
    textFieldPlaceholder: "#aaaaaa"
    textFieldSelection: "#aaaaaa"

    button: "#e6e5eb"

    separator: "#dbdbdd"

    scrollBar: "#20000000"

    dialogOverlay: "#30000000"
    dialogBackground: "#ffffff"
    dialogShadow: "#ff000000"

    sliderFilledStripe: "#000000"
    sliderEmptyStripe: "#aaaaaa"
    sliderHandle: "#ffffff"
    sliderHandleBorder: "#555555"

    tooltipBackground: "#cc424242"
    tooltipText: "#ffffff"

    switcherBackground: "#ffffff"
    switcherBorder: "#cccccc"
    switcherHandle: "#cccccc"

    contextMenuButton: "#cc424242"
    contextMenuButtonPressed: "#ff424242"
    contextMenuButtonText: "#ffffff"

    lineNumbersBackground:"#e6e5eb"
    lineNumber: "#aaaaaa"

    editorSelection: "#aaaaaa"
    editorSelectedText: "#ffffff"

    editorSelectionHandle: "#167ffc"

    editorNormal: "#222222"
    editorComment: "#008000"
    editorNumber: "#000080"
    editorString: "#008000"
    editorOperator: "#222222"
    editorKeyword: "#808000"
    editorBuiltIn: "#0055af"
    editorMarker: "#ffff00"
    editorItem: "#800080"
    editorProperty: "#800000"
}
