import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtMultimedia 5.4

/*
    This example was working fine in Qt 5.4.1
    It isn't working in 5.4.2 and 5.5.0
    Hopefully, someone will fix video streaming in 5.5.1
*/

Item {
    anchors.fill: parent

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: spacing

        ComboBox {
            Layout.fillWidth: true
            model: WebcamsModel {
                id: comboBoxModel
            }
            onCurrentIndexChanged: video.source = comboBoxModel.get(currentIndex).stream
        }


        Video {
            id: video
            Layout.fillWidth: true
            Layout.fillHeight: true
            autoPlay: true
            source: comboBoxModel.get(0).stream
        }
    }
}
