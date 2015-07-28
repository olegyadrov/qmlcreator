import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import "Database.js" as Db

Item {
    anchors.fill: parent

    function updateRecords() {
        recordsListModel.clear()

        var records = Db.getRecords()

        for (var i = 0; i < records.length; i++) {
            recordsListModel.append({
                "recordId": records[i].id,
                "recordContent": records[i].content
            })
        }
    }

    ListModel {
        id: recordsListModel

        Component.onCompleted: {
            Db.init()
            updateRecords()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: spacing

        RowLayout {
            TextField {
                id: textField
                Layout.fillWidth: true
                inputMethodHints: Qt.ImhNoPredictiveText
            }

            Button {
                text: "Insert"
                enabled: textField.length > 0

                onClicked: {
                    Db.insertRecord(textField.text)
                    updateRecords()
                }
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            model: recordsListModel

            delegate: RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right

                Label {
                    Layout.fillWidth: true
                    text: model.recordId + ". " + model.recordContent
                }

                Button {
                    text: "x"
                    onClicked: {
                        Db.removeRecord(model.recordId)
                        updateRecords()
                    }
                }
            }
        }
    }
}
