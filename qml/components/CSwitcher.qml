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
    id: cSwitcher

    implicitWidth: 40 * settings.pixelDensity
    implicitHeight: 12 * settings.pixelDensity

    property alias leftText: leftLabel.text
    property alias rightText: rightLabel.text
    property bool leftPosition: true

    Rectangle {
        anchors.fill: parent
        color: palette.switcherBackground
        border.width: Math.max(1, Math.round(0.3 * settings.pixelDensity))
        border.color: palette.switcherBorder
    }

    Item {
        width: parent.width * 0.9
        height: parent.height * 0.7
        anchors.centerIn: parent

        CVerticalSeparator {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            x: cSwitcher.leftPosition ? 0 : parent.width - width

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width * 0.44

            color: palette.switcherHandle

            Behavior on x {
                NumberAnimation {
                    duration: 120
                }
            }
        }
    }

    CLabel {
        id: leftLabel
        anchors.left: parent.left
        anchors.leftMargin: 3.2 * settings.pixelDensity
        anchors.verticalCenter: parent.verticalCenter
    }

    CLabel {
        id: rightLabel
        anchors.right: parent.right
        anchors.rightMargin: 3.2 * settings.pixelDensity
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked:
            leftPosition = !leftPosition
    }
}

