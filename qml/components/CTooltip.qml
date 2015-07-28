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
    id: cTooltip
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: 26 * settings.pixelDensity
    height: 16 * settings.pixelDensity
    visible: opacity > 0
    opacity: 0

    Behavior on opacity {
        NumberAnimation {
            duration: 300
        }
    }

    Timer {
        id: timer
        repeat: false
        running: false
        interval: 2000
        onTriggered:
            cTooltip.opacity = 0
    }

    function show(text) {
        label.text = text
        cTooltip.opacity = 1
        timer.restart()
    }

    Rectangle {
        id: background
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        radius: height / 2
        width: Math.min(label.contentWidth + 12 * settings.pixelDensity, cTooltip.width - 12 * settings.pixelDensity)
        color: palette.tooltipBackground
    }

    CLabel {
        id: label
        anchors.fill: parent
        anchors.leftMargin: 9 * settings.pixelDensity
        anchors.rightMargin: 9 * settings.pixelDensity
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
        color: palette.tooltipText
    }
}
