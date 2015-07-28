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
import QtQuick.Layouts 1.2

Item {
    id: cToolButton

    implicitWidth: 22 * settings.pixelDensity
    implicitHeight: 22 * settings.pixelDensity
    property alias icon: buttonIcon.text
    property string tooltipText

    signal clicked()

    Rectangle {
        anchors.fill: parent
        color: palette.button
        visible: mouseArea.pressed
    }

    CIcon {
        id: buttonIcon
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        visible: text !== ""
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: cToolButton.clicked()
        onPressAndHold: tooltip.show(cToolButton.tooltipText)
    }
}
