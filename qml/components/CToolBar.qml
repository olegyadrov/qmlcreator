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

Rectangle {
    id: cToolBar
    height: 22 * settings.pixelDensity
    z: 2
    color: palette.toolBarBackground

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: Math.max(1, Math.round(0.8 * settings.pixelDensity))
        color: palette.toolBarStripe
        z: 2
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        height: 1.8 * settings.pixelDensity
        gradient: Gradient {
            GradientStop { position: 0; color: palette.toolBarShadowBegin }
            GradientStop { position: 1; color: palette.toolBarShadowEnd }
        }
    }
}
