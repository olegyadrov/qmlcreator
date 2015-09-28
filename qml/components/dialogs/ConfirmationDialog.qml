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
import QtGraphicalEffects 1.0
import ".."

BaseDialog {
    id: confirmationDialog

    property alias title: titleLabel.text
    property alias text: message.text

    function initialize(parameters) {
        for (var attr in parameters) {
            confirmationDialog[attr] = parameters[attr]
        }
    }

    DropShadow {
        anchors.fill: contentBackground
        radius: 5 * settings.pixelDensity
        color: palette.dialogShadow
        transparentBorder: true
        fast: true
        source: contentBackground
    }

    Rectangle {
        id: contentBackground
        width: popupWidth
        height: popupHeight
        anchors.centerIn: parent
        color: palette.dialogBackground
    }

    Item {
        width: popupWidth
        height: popupHeight
        anchors.centerIn: parent

        Rectangle {
            id: header

            height: 22 * settings.pixelDensity
            anchors.left: parent.left
            anchors.right: parent.right
            color: palette.toolBarBackground

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                height: Math.max(1, Math.round(0.8 * settings.pixelDensity))
                color: palette.toolBarStripe
            }

            CLabel {
                id: titleLabel
                anchors.fill: parent
                anchors.leftMargin: 5 * settings.pixelDensity
                font.pixelSize: 10 * settings.pixelDensity
            }
        }

        CFlickable {
            id: flickable
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: footer.top
            clip: true

            contentHeight: message.contentHeight
            boundsBehavior: Flickable.StopAtBounds

            TextEdit {
                id: message

                anchors.fill: parent
                textMargin: 3 * settings.pixelDensity

                wrapMode: Text.Wrap
                font.family: "Roboto"
                font.pixelSize: 6 * settings.pixelDensity
                color: palette.label
                readOnly: true
            }
        }

        CScrollBar {
            flickableItem: flickable
        }

        CDialogButton {
            anchors.left: parent.left
            anchors.right: footer.left
            anchors.bottom: parent.bottom
            text: qsTr("Cancel")
            onClicked: confirmationDialog.process(false)
        }

        CVerticalSeparator {
            id: footer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }

        CDialogButton {
            anchors.left: footer.right
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            text: qsTr("OK")
            onClicked: confirmationDialog.process(true)
        }
    }
}
