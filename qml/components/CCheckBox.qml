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
    id: cCheckBox

    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: 18.5 * settings.pixelDensity
    property alias label: buttonLabel
    property alias text: buttonLabel.text
    property bool checked: false

    signal clicked()

    CHorizontalSeparator {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    Rectangle {
        anchors.fill: parent
        color: palette.button
        visible: mouseArea.pressed
    }

    CLabel {
        id: buttonLabel
        anchors.left: parent.left
        anchors.right: buttonIcon.left
        anchors.leftMargin: 5 * settings.pixelDensity
        anchors.rightMargin: 3 * settings.pixelDensity
        anchors.verticalCenter: parent.verticalCenter
    }

    CIcon {
        id: buttonIcon
        anchors.left: parent.left
        anchors.leftMargin: parent.width - 15 * settings.pixelDensity
        anchors.verticalCenter: parent.verticalCenter
        text: cCheckBox.checked ? "\uf046" : "\uf096"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            cCheckBox.clicked()
        }
    }
}
