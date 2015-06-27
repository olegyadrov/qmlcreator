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
import SyntaxHighlighter 1.1

Item {
    id: cCodeArea

    property alias text: textEdit.text
    property alias selectedText: textEdit.selectedText
    property int indentSize: 0

    onIndentSizeChanged: {
        var indentString = ""
        for (var i = 0; i < indentSize; i++)
            indentString += " "
        textEdit.indentString = indentString
    }

    function paste() {
        textEdit.textChangedManually = true
        textEdit.paste()
    }

    function copy() {
        textEdit.copy()
    }

    function cut() {
        textEdit.textChangedManually = true
        textEdit.cut()
    }

    function selectAll() {
        textEdit.selectAll()
        textEdit.leftSelectionHandle.setPosition()
        textEdit.rightSelectionHandle.setPosition()
    }

    onActiveFocusChanged: {
        if (activeFocus)
            textEdit.forceActiveFocus()
    }

    Rectangle {
        id: lineNumbers
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: column.width * 1.2
        color: palette.lineNumbersBackground

        Column {
            id: column
            y: 2 * settings.pixelDensity - flickable.contentY
            anchors.horizontalCenter: parent.horizontalCenter

            Repeater {
                model: textEdit.lineCount
                delegate: Text {
                    anchors.right: column.right
                    color: index + 1 === textEdit.currentLine ? palette.label : palette.lineNumber
                    font.family: settings.font
                    font.pixelSize: settings.fontSize
                    font.bold: index + 1 === textEdit.currentLine
                    text: index + 1
                }
            }
        }
    }

    CFlickable {
        id: flickable
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: lineNumbers.right
        anchors.right: (scrollBar.visible) ? scrollBar.left : parent.right

        interactive: false

        function ensureVisible(cursor)
        {
            if (textEdit.currentLine === 1)
                contentY = 0
            else if (textEdit.currentLine === textEdit.lineCount && flickable.visibleArea.heightRatio < 1)
                contentY = contentHeight - height
            else
            {
                if (contentY >= cursor.y)
                    contentY = cursor.y
                else if (contentY + height <= cursor.y + cursor.height)
                    contentY = cursor.y + cursor.height - height
            }
        }

        TextEdit {
            id: textEdit
            anchors.left: parent.left
            anchors.right: parent.right

            color: palette.editorNormal
            selectionColor: palette.editorSelection
            selectedTextColor: palette.editorSelectedText

            font.family: settings.font
            font.pixelSize: settings.fontSize
            textMargin: 2 * settings.pixelDensity
            wrapMode: TextEdit.Wrap
            textFormat: TextEdit.PlainText
            inputMethodHints: Qt.ImhNoPredictiveText
            activeFocusOnPress: false

            property string indentString: ""

            property int currentLine: cursorRectangle.y / cursorRectangle.height + 1
            onCursorRectangleChanged: flickable.ensureVisible(cursorRectangle)

            onContentHeightChanged:
                flickable.contentHeight = contentHeight

            property bool textChangedManually: false
            property string previousText: ""
            onLengthChanged: {
                if (settings.indentSize === 0)
                    return

                // This is kind of stupid workaround, we forced to do this check because TextEdit sends
                // us "textChanged" and "lengthChanged" signals after every select() and forceActiveFocus() call
                if (text !== previousText)
                {
                    if (textChangedManually)
                    {
                        previousText = text
                        textChangedManually = false
                        return
                    }

                    if (length > previousText.length)
                    {
                        var textBeforeCursor
                        var openBrackets
                        var closeBrackets
                        var openBracketsCount
                        var closeBracketsCount
                        var indentLevel
                        var indentString

                        var lastCharacter = text[cursorPosition - 1]

                        switch (lastCharacter)
                        {
                        case "\n":
                            textBeforeCursor = text.substring(0, cursorPosition - 1)
                            openBrackets = textBeforeCursor.match(/\{/g)
                            closeBrackets = textBeforeCursor.match(/\}/g)

                            if (openBrackets !== null)
                            {
                                openBracketsCount = openBrackets.length
                                closeBracketsCount = 0

                                if (closeBrackets !== null)
                                    closeBracketsCount = closeBrackets.length

                                indentLevel = openBracketsCount - closeBracketsCount
                                indentString = new Array(indentLevel + 1).join(textEdit.indentString)
                                textChangedManually = true
                                insert(cursorPosition, indentString)
                            }
                            break
                        case "}":
                            var lineBreakPosition
                            for (var i = cursorPosition - 2; i >= 0; i--)
                            {
                                if (text[i] !== " ")
                                {
                                    if (text[i] === "\n")
                                        lineBreakPosition = i

                                    break
                                }
                            }

                            if (lineBreakPosition !== undefined)
                            {
                                textChangedManually = true
                                remove(lineBreakPosition + 1, cursorPosition - 1)

                                textBeforeCursor = text.substring(0, cursorPosition - 1)
                                openBrackets = textBeforeCursor.match(/\{/g)
                                closeBrackets = textBeforeCursor.match(/\}/g)

                                if (openBrackets !== null)
                                {
                                    openBracketsCount = openBrackets.length
                                    closeBracketsCount = 0

                                    if (closeBrackets !== null)
                                        closeBracketsCount = closeBrackets.length

                                    indentLevel = openBracketsCount - closeBracketsCount - 1
                                    indentString = new Array(indentLevel + 1).join(textEdit.indentString)
                                    textChangedManually = true
                                    insert(cursorPosition - 1, indentString)
                                }
                            }

                            break
                        }
                    }

                    previousText = text
                }
            }

            SyntaxHighlighter {
                id: syntaxHighlighter

                normalColor: palette.editorNormal
                commentColor: palette.editorComment
                numberColor: palette.editorNumber
                stringColor: palette.editorString
                operatorColor: palette.editorOperator
                keywordColor: palette.editorKeyword
                builtInColor: palette.editorBuiltIn
                markerColor: palette.editorMarker
                itemColor: palette.editorItem
                propertyColor: palette.editorProperty
            }

            Component.onCompleted: {
                syntaxHighlighter.setHighlighter(textEdit)
                if (projectManager.project !== "") {
                    // add custom components
                    var files = projectManager.files()
                    for (var i = 0; i < files.length; i++) {
                        var filename = files[i].split(".")
                        if (filename[0] !== "main") {
                            if (filename[1] === "qml")
                                syntaxHighlighter.addQmlComponent(filename[0])
                            if (filename[1] === "js")
                                syntaxHighlighter.addJsComponent(filename[0])
                        }
                    }
                    syntaxHighlighter.rehighlight()
                }
            }

            MouseArea {
                anchors.fill: parent

                preventStealing: true

                property int startX
                property int startY
                property int startPosition
                property int endPosition

                onPressed: {
                    textEdit.contextMenu.visible = false

                    startX = mouse.x
                    startY = mouse.y
                    startPosition = textEdit.positionAt(mouse.x, mouse.y)
                    textEdit.cursorPosition = startPosition
                    textEdit.forceActiveFocus()

                    mouse.accepted = true
                }

                onPositionChanged: {
                    if (textEdit.contextMenu.visible)
                    {
                        mouse.accepted = true
                        return
                    }

                    var newPosition = textEdit.positionAt(mouse.x, mouse.y)
                    if (newPosition !== endPosition)
                    {
                        endPosition = newPosition
                        textEdit.select(startPosition, endPosition)
                    }
                    mouse.accepted = true
                }

                onPressAndHold: {
                    var distance = Math.sqrt(Math.pow(mouse.x - startX, 2) + Math.pow(mouse.y - startY, 2))
                    if (distance < textEdit.cursorRectangle.height)
                    {
                        if (textEdit.selectedText.length === 0)
                            textEdit.contextMenu.visible = true
                    }
                    mouse.accepted = true
                }
            }

            property Item leftSelectionHandle: Item {
                width: textEdit.cursorRectangle.height
                height: width
                parent: textEdit
                visible: textEdit.selectedText !== ""
                onXChanged:
                    if (leftSelectionMouseArea.pressed)
                        select()
                onYChanged:
                    if (leftSelectionMouseArea.pressed)
                        select()

                function select() {
                    var currentPosition = textEdit.positionAt(x + width / 2, y + height)
                    if (currentPosition < textEdit.selectionEnd)
                        textEdit.select(currentPosition, textEdit.selectionEnd)
                }

                function setPosition() {
                    var positionRectangle = textEdit.positionToRectangle(textEdit.selectionStart)
                    textEdit.leftSelectionHandle.x = positionRectangle.x - textEdit.leftSelectionHandle.width / 2
                    textEdit.leftSelectionHandle.y = positionRectangle.y - textEdit.leftSelectionHandle.height
                }

                MouseArea {
                    id: leftSelectionMouseArea
                    anchors.fill: parent
                    anchors.margins: -parent.width / 1.5
                    drag.target: textEdit.leftSelectionHandle
                    drag.smoothed: false
                    onReleased:
                        textEdit.leftSelectionHandle.setPosition()
                }

                Connections {
                    target: (leftSelectionMouseArea.pressed) ? null : textEdit
                    onCursorPositionChanged:
                        textEdit.leftSelectionHandle.setPosition()
                }

                Rectangle {
                    anchors.horizontalCenter: parent.left
                    width: parent.width
                    height: parent.height
                    radius: width / 2
                    color: palette.editorSelectionHandle

                    Rectangle {
                        width: Math.floor(parent.width / 2)
                        height: width
                        color: parent.color
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                    }
                }
            }

            property Item rightSelectionHandle: Item {
                width: textEdit.cursorRectangle.height
                height: width
                parent: textEdit
                visible: textEdit.selectedText !== ""
                onXChanged:
                    if (rightSelectionMouseArea.pressed)
                        select()
                onYChanged:
                    if (rightSelectionMouseArea.pressed)
                        select()

                function select() {
                    var currentPosition = textEdit.positionAt(x + width / 2, y)
                    if (currentPosition > textEdit.selectionStart)
                        textEdit.select(textEdit.selectionStart, currentPosition)
                }

                function setPosition() {
                    var positionRectangle = textEdit.positionToRectangle(textEdit.selectionEnd)
                    textEdit.rightSelectionHandle.x = positionRectangle.x - textEdit.rightSelectionHandle.width / 2
                    textEdit.rightSelectionHandle.y = positionRectangle.y + positionRectangle.height
                }

                MouseArea {
                    id: rightSelectionMouseArea
                    anchors.fill: parent
                    anchors.margins: -parent.width / 1.5
                    drag.target: textEdit.rightSelectionHandle
                    drag.smoothed: false
                    onReleased:
                        textEdit.rightSelectionHandle.setPosition()
                }

                Connections {
                    target: (rightSelectionMouseArea.pressed) ? null : textEdit
                    onCursorPositionChanged:
                        textEdit.rightSelectionHandle.setPosition()
                }

                Rectangle {
                    anchors.horizontalCenter: parent.right
                    width: parent.width
                    height: parent.height
                    radius: width / 2
                    color: palette.editorSelectionHandle

                    Rectangle {
                        width: Math.floor(parent.width / 2)
                        height: width
                        color: parent.color
                        anchors.top: parent.top
                        anchors.left: parent.left
                    }
                }
            }

            property Item contextMenu: ListView {
                parent: textEdit
                visible: false

                property int margin: 3
                property int delegateWidth: 40 * settings.pixelDensity
                property int delegateHeight: 12 * settings.pixelDensity

                width: delegateWidth
                height: delegateHeight * count
                boundsBehavior: Flickable.StopAtBounds

                model: ListModel {
                    ListElement {
                        text: "Paste"
                    }
                }

                function contextMenuCallback(index) {
                    visible = false
                    switch (index)
                    {
                    case 0:
                        cCodeArea.paste()
                        break
                    }
                }

                delegate: CContextMenuButton {
                    width: ListView.view.delegateWidth
                    height: ListView.view.delegateHeight
                    text: model.text
                    onClicked: ListView.view.contextMenuCallback(index)
                }

                onVisibleChanged: {
                    if (visible)
                    {
                        var positionRectangle = textEdit.positionToRectangle(textEdit.cursorPosition)

                        if (isEnoughSpaceAtLeft() && !isEnoughSpaceAtRight())
                            x = textEdit.width - width - margin
                        else if (!isEnoughSpaceAtLeft() && isEnoughSpaceAtRight())
                            x = margin
                        else
                            x = positionRectangle.x - width / 2

                        if (isEnoughSpaceAtTop())
                            y = positionRectangle.y - margin - height
                        else if (isEnoughSpaceAtBottom())
                            y = positionRectangle.y + positionRectangle.height + margin
                        else
                            y = positionRectangle.y + positionRectangle.height / 2 - height / 2
                    }
                }

                function isEnoughSpaceAtTop() {
                    var positionRectangle = textEdit.positionToRectangle(textEdit.cursorPosition)
                    return (positionRectangle.y  - height - margin > 0)
                }

                function isEnoughSpaceAtBottom() {
                    var positionRectangle = textEdit.positionToRectangle(textEdit.cursorPosition)
                    return (positionRectangle.y  + positionRectangle.height + height + margin < textEdit.height)
                }

                function isEnoughSpaceAtLeft() {
                    var positionRectangle = textEdit.positionToRectangle(textEdit.cursorPosition)
                    return (positionRectangle.x - width / 2 > 0)
                }

                function isEnoughSpaceAtRight() {
                    var positionRectangle = textEdit.positionToRectangle(textEdit.cursorPosition)
                    return (positionRectangle.x + width / 2 < textEdit.width)
                }
            }
        }
    }

    CNavigationScrollBar {
        id: scrollBar

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        flickableItem: flickable
    }
}
