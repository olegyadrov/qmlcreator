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
import QtGraphicalEffects 1.0
import ".."

BaseDialog {
    id: newFileDialog

    property alias title: titleLabel.text

    function initialize(parameters) {
        for (var attr in parameters) {
            newFileDialog[attr] = parameters[attr]
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

        Flickable {
            id: flickable

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: footer.top
            boundsBehavior: Flickable.StopAtBounds
            clip: true

            property double margin: 3 * settings.pixelDensity

            leftMargin: margin
            rightMargin: margin
            topMargin: margin
            bottomMargin: margin

            contentWidth: width - margin * 2
            contentHeight: column.height

            Column {
                id: column
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 2 * settings.pixelDensity

                CLabel {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: qsTr("File name") + ":"
                }

                CTextField {
                    id: fileNameTextField

                    validator: RegExpValidator {
                        regExp: new RegExp("^[A-Z][a-zA-Z0-9]*")
                    }

                    onTextChanged: {
                        if (warningLabel.visible)
                            warningLabel.visible = false
                    }
                }

                CLabel {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: qsTr("File type") + ":"
                }

                CSwitcher {
                    id: fileTypeSwitcher
                    leftText: "QML"
                    rightText: "JS"
                }

                CLabel {
                    id: warningLabel
                    anchors.left: parent.left
                    anchors.right: parent.right
                    wrapMode: Text.WordWrap
                    color: palette.warning
                    visible: false
                }

                CLabel {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    text: qsTr("Note: the file name must start with a capital letter and cannot contain spaces (e.g., MyItem.qml)")
                    wrapMode: Text.Wrap
                }
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
            onClicked: newFileDialog.close()
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
            onClicked: {
                var fileName = fileNameTextField.text
                var fileExtension = fileTypeSwitcher.leftPosition ? "qml" : "js"

                if (fileName.length === 0)
                {
                    warningLabel.text = qsTr("The file name cannot be left blank")
                    warningLabel.visible = true
                }
                else
                {
                    if (projectManager.fileExists(fileName + "." + fileExtension))
                    {
                        warningLabel.text = qsTr("The file already exists")
                        warningLabel.visible = true
                    }
                    else
                    {
                        var value = {
                            fileName: fileName,
                            fileExtension: fileExtension
                        }

                        newFileDialog.process(value)
                    }
                }
            }
        }
    }
}
