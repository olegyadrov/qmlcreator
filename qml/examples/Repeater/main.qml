import QtQuick 2.4

Item {
  anchors.fill: parent

  Grid {
    anchors.centerIn: parent
    columns: parent.width / 100
    rows: parent.height / 100

    Repeater {
      model: parent.columns * parent.rows
      delegate: ColorRect { }
    }
  }
}
