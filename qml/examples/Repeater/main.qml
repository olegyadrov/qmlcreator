import QtQuick 2.4
import QtQuick.Window 2.2

Item {
    anchors.fill: parent

    property int rectSize: 14 * Screen.logicalPixelDensity

    Grid {
        anchors.centerIn: parent
        columns: parent.width / rectSize
        rows: parent.height / rectSize

        Repeater {
            model: parent.columns * parent.rows
            delegate: ColorRect {
                width: rectSize
                height: rectSize
            }
        }
    }
}
