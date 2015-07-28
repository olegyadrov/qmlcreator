import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2

SwipeScreen {
    onSelected: firstNameTextField.forceActiveFocus()

    ColumnLayout {
        anchors.centerIn: parent

        GridLayout {
            columns: 2

            Label { text: "First Name" }
            TextField {
                id: firstNameTextField
                Layout.fillWidth: true
            }

            Label { text: "Last Name" }
            TextField {
                Layout.fillWidth: true
            }

            Label { text: "Your Email" }
            TextField {
                Layout.fillWidth: true
            }

            Label { text: "New Password" }
            TextField {
                Layout.fillWidth: true
                echoMode: TextInput.Password
            }
        }

        CheckBox {
            id: checkBox
            Layout.fillWidth: true
            text: "I agree to the <a href=\"http://google.com\">Terms and Conditions</a>"
        }

        Button {
            Layout.fillWidth: true
            enabled: checkBox.checked
            text: "Create an account"
        }
    }
}
