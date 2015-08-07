import QtQuick 2.5
import QtQuick.Window 2.2

LoopedListView {
    id: numberSelector

    delegateWidth: 24 * Screen.logicalPixelDensity
    delegateHeight: 20 * Screen.logicalPixelDensity

    property int value: 0
    property int minimumValue: 0
    property int maximumValue: 5
    property bool updateValueWhileMoving: true

    // for internal usage
    property int numberCount: 0
    property bool initialized: false

    model: numberCount

    onCurrentIndexChanged: {
        if (initialized && updateValueWhileMoving)
            value = minimumValue + currentIndex
    }

    onMovementEnded: {
        value = minimumValue + currentIndex
    }

    Component.onCompleted: {
        numberCount = maximumValue - minimumValue + 1

        if (value < minimumValue)
            value = minimumValue
        else if (value > maximumValue)
            value = maximumValue

        positionViewAtIndex(value - minimumValue, PathView.SnapPosition)
        initialized = true
    }

    onMinimumValueChanged: {
        if (initialized) {
            var oldValue = value
            numberCount = maximumValue - minimumValue + 1

            if (oldValue < minimumValue)
                oldValue = minimumValue

            value = oldValue
            positionViewAtIndex(oldValue - minimumValue, PathView.SnapPosition)
        }
    }

    onMaximumValueChanged: {
        if (initialized) {
            var oldValue = value
            numberCount = maximumValue - minimumValue + 1

            if (oldValue > maximumValue)
                oldValue = maximumValue

            value = oldValue
            positionViewAtIndex(oldValue - minimumValue, PathView.SnapPosition)
        }
    }

    delegate:
        LoopedListViewDelegate {
            Text {
                anchors.fill: parent
                text: numberSelector.minimumValue + index
                font.pixelSize: 8 * Screen.logicalPixelDensity
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked:
                    numberSelector.currentIndex = index
            }
        }
}
