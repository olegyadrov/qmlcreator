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

Item {
    id: cTextArea

    property alias text: textEdit.text

    function textStyle() {
        return "<style>a:link { color: " + palette.link + "; text-decoration: none; }</style>"
    }

    CFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: textEdit.contentHeight

        TextEdit {
            id: textEdit
            anchors.fill: parent

            color: palette.label
            font.family: "Roboto"
            font.pixelSize: 6 * settings.pixelDensity
            textMargin: 3 * settings.pixelDensity
            readOnly: true
            wrapMode: TextEdit.Wrap
            textFormat: TextEdit.RichText
            activeFocusOnPress: false
            onLinkActivated: Qt.openUrlExternally(link)
        }
    }

    CScrollBar {
        flickableItem: flickable
    }
}
