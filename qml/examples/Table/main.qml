import QtQuick 2.4
import QtQuick.Controls 1.3

TableView {
  anchors.fill: parent

  TableViewColumn {
    role: "version"
    title: "Version"
  }

  TableViewColumn {
    width: 600
    role: "release"
    title: "Release"
  }

  model: ListModel {
    ListElement{
      version: "5.3.2"
      release: "16 September 2014"
    }

    ListElement{
      version: "5.0.0"
      release: "19 December 2012"
    }

    ListElement{
      version: "4.0.0"
      release: "29 June 2005"
    }

    ListElement{
      version: "3.0"
      release: "16 October 2001"
    }

    ListElement{
      version: "2.0"
      release: "26 June 1999"
    }

    ListElement{
      version: "1.40"
      release: "10 July 1998"
    }
  }
}
