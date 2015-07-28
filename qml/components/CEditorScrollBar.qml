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

Item {
    id: cEditorScrollBar
    property var flickableItem
    implicitWidth: 12 * settings.pixelDensity
    clip: true
    visible: enabled

    Rectangle {
        id: handler
        y: flickableItem.contentY / flickableItem.contentHeight * cVerticalScrollBar.height
        anchors.left: parent.left
        anchors.right: parent.right
        height: (cVerticalScrollBar.height / flickableItem.contentHeight >= 1) ?
                    cVerticalScrollBar.height :
                    cVerticalScrollBar.height / flickableItem.contentHeight * cVerticalScrollBar.height
        color: "#cccccc"
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true

        onMouseYChanged:
            if (mouseY - handler.height / 2 <= 0) {
                flickableItem.contentY = 0
            }
            else if ((mouseY - handler.height / 2) * flickableItem.contentHeight / cVerticalScrollBar.height >=
                     flickableItem.contentHeight - cVerticalScrollBar.height) {
                flickableItem.contentY = flickableItem.contentHeight - cVerticalScrollBar.height
            }
            else
                flickableItem.contentY = (mouseY - handler.height / 2) * flickableItem.contentHeight / cVerticalScrollBar.height
    }
}
