import QtQuick 2.5

Item {
    width: row.childrenRect.width
    height: row.childrenRect.height

    property alias day: daySelector.value
    property alias month: monthSelector.value
    property alias year: yearSelector.value

    // http://jsperf.com/days-in-month-perf-test
    function daysInMonth(m, y) {
        switch (m) {
            case 1 :
                return (y % 4 == 0 && y % 100) || y % 400 == 0 ? 29 : 28;
            case 8 : case 3 : case 5 : case 10 :
                return 30;
            default :
                return 31
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#cccccc"
        border.color: "#000000"
        border.width: 1
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 1
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height / 3
    }

    Row {
        id: row

        anchors.centerIn: parent

        NumberSelector {
            id: daySelector
            minimumValue: 1
            maximumValue: daysInMonth(new Date().getMonth(), new Date().getFullYear())
            value: new Date().getDate()
        }

        NumberSelector {
            id: monthSelector
            minimumValue: 1
            maximumValue: 12
            value: new Date().getMonth() + 1
            onValueChanged: {
                daySelector.maximumValue = daysInMonth(value - 1, yearSelector.value)
            }
        }

        NumberSelector {
            id: yearSelector
            minimumValue: new Date().getFullYear() - 80
            maximumValue: new Date().getFullYear()
            value: new Date().getFullYear()
            onValueChanged: {
                daySelector.maximumValue = daysInMonth(monthSelector.value - 1, value)
            }
        }
    }
}
