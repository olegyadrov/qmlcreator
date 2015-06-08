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
import QtQuick.Layouts 1.1

Item {
    id: cBackButton

    property alias text: buttonLabel.text

    Rectangle {
        id: background
        anchors.fill: parent
        color: palette.button
        visible: mouseArea.pressed
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 5 * settings.pixelDensity
        anchors.rightMargin: 5 * settings.pixelDensity
        spacing: 3 * settings.pixelDensity

        CIcon {
            text: ""
        }

        CLabel {
            id: buttonLabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            font.pixelSize: 10 * settings.pixelDensity
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (!stackView.busy)
                stackView.pop()
        }
    }
}
