import QtQuick 2.5

PathView {
    id: pathView

    clip: true

    property int delegateWidth: 100
    property int delegateHeight: 100
    property int visibleItemCount: 3

    width: delegateWidth
    height: delegateHeight * visibleItemCount
    preferredHighlightBegin: (1 + visibleItemCount / 3) / count
    preferredHighlightEnd: (1 + visibleItemCount / 3) / count

    path: Path {
        startX: pathView.delegateWidth / 2
        startY: -pathView.delegateHeight / 2

        PathLine {
            x: pathView.delegateWidth / 2
            y: pathView.delegateHeight * pathView.visibleItemCount
        }

        PathLine {
            x: pathView.delegateWidth / 2
            y: pathView.delegateHeight * pathView.count - pathView.delegateHeight / 2
        }
    }
}
