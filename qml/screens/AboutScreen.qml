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
import "../components"

BlankScreen {
    id: aboutScreen

    CToolBar {
        id: toolBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        CBackButton {
            anchors.fill: parent
            text: qsTr("About")
        }
    }

    CTextArea {
        anchors.top: toolBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        text:  textStyle() +
               Qt.application.name + " " + Qt.application.version + "<br>
               Based on Qt Quick 2.4 (Qt 5.4.2)<br>
               Built on Jul 23 2015<br><br>
               Copyright (C) 2013-2015 <a href=\"https://linkedin.com/in/olegyadrov/\">Oleg Yadrov</a><br>
               <a class=\"link\" href=\"mailto:wearyinside@gmail.com\">wearyinside@gmail.com</a><br><br>

               QML Creator application is distributed under
               <a href=\"http://www.apache.org/licenses/LICENSE-2.0\">Apache Software License, Version 2</a>.<br><br>

               It's available through
               <a href=\"https://play.google.com/store/apps/details?id=com.wearyinside.qmlcreator\">Google Play</a>
               and
               <a href=\"https://itunes.apple.com/us/app/qml-creator/id944301984\">App Store</a>,
               the source code is available at <a href=\"https://github.com/wearyinside/qmlcreator\">https://github.com/wearyinside/qmlcreator</a><br><br>

               You are welcome to support me by donating some bitcoins to
               <a href=\"https://blockchain.info/address/1weary24fY4PqH542yGEgwZcYksGv7zLB\">1weary24fY4PqH542yGEgwZcYksGv7zLB</a><br><br>

               Unless required by applicable law or agreed to in writing, software distributed under the License
               is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.<br><br>

               Qt is a registered trademark of The Qt Company Ltd. and/or its subsidiaries."
    }
}
