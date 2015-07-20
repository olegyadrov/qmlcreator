import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    GridLayout {
        anchors.fill: parent

        columns: 2

        BusyIndicator {
            id: normalIndicator
            Layout.alignment: Qt.AlignCenter
        }
        BusyIndicator {
            id: styledIndicator
            Layout.alignment: Qt.AlignCenter
            style: SBusyIndicatorStyle {}
        }

        Button {
            Layout.alignment: Qt.AlignCenter
            text: "Normal"
            onClicked:
                normalIndicator.running = !normalIndicator.running
        }
        Button {
            Layout.alignment: Qt.AlignCenter
            text: "Styled"
            style: SButtonStyle {}
            onClicked:
                styledIndicator.running = !styledIndicator.running
        }
    }
}
