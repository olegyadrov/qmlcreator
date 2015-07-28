import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

SwipeScreen {
    onSelected: emailTextField.forceActiveFocus()

    ColumnLayout {
        anchors.centerIn: parent

        RowLayout {
            Label { text: "Email" }
            TextField {
                id: emailTextField
                Layout.fillWidth: true
            }
        }

        Button {
            Layout.fillWidth: true
            text: "Send instructions"
        }
    }
}
