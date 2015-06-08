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
    id: cSlider

    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: 18.5 * settings.pixelDensity

    property int handleRadius: 5 * settings.pixelDensity
    property double value

    Item {
        id: slideArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: handleRadius

        height: 1.4 * settings.pixelDensity

        Rectangle {
            anchors.left: parent.left
            anchors.right: handle.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: palette.sliderFilledStripe
        }

        Rectangle {
            anchors.left: handle.horizontalCenter
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: palette.sliderEmptyStripe
        }

        Rectangle {
            id: handle
            anchors.verticalCenter: parent.verticalCenter
            x: cSlider.value * slideArea.width - width / 2
            width: handleRadius * 2
            height: handleRadius * 2
            radius: handleRadius
            color: palette.sliderHandle
            border.width: 1 * settings.pixelDensity
            border.color: palette.sliderHandleBorder
        }
    }

    MouseArea {
        anchors.fill: parent
        anchors.leftMargin: handleRadius
        anchors.rightMargin: handleRadius
        preventStealing: true

        function changeValue() {
            var value = mouseX / width
            if (value > 1)
                cSlider.value = 1
            else if (value < 0)
                cSlider.value = 0
            else
                cSlider.value = value
        }

        onPositionChanged:
            changeValue()

        onPressed:
            changeValue()
    }
}

