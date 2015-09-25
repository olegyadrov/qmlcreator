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
import QtQuick.Controls 1.4
import "components"
import "components/dialogs"
import "screens"

CApplicationWindow {
    id: appWindow

    onBackPressed: {
        if (dialog.visible)
        {
            dialog.close()
        }
        else
        {
            if (stackView.depth > 1)
                stackView.pop()
            else
                Qt.quit()
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: MainMenuScreen { }
        enabled: !dialog.visible
    }

    DialogLoader {
        id: dialog
        anchors.fill: parent
    }

    CTooltip {
        id: tooltip
    }
}
