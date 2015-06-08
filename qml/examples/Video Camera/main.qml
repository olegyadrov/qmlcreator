import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtMultimedia 5.4

Item {
  anchors.fill: parent

  Camera {
    id: camera
    captureMode: Camera.CaptureVideo
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    VideoOutput {
      Layout.fillWidth: true
      Layout.fillHeight: true
      source: camera
      autoOrientation: true

      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        text: camera.displayName

        Rectangle {
          anchors.fill: parent
          z: -1
        }
      }
    }

    RowLayout {
      Layout.fillWidth: true

      Button {
        text: "Record"
        visible: camera.videoRecorder.recorderStatus == CameraRecorder.LoadedStatus
        onClicked: camera.videoRecorder.record()
      }

      Button {
        text: "Stop"
        visible: camera.videoRecorder.recorderStatus == CameraRecorder.RecordingStatus
        onClicked: {
          camera.videoRecorder.stop()
          previewVideo.visible = true
        }
      }

      Item {
        Layout.fillWidth: true
      }

      Button {
        text: if (camera.lockStatus == Camera.Unlocked) "Focus";
              else if (camera.lockStatus == Camera.Searching) "Focusing"
              else "Unlock"
        visible: camera.cameraStatus == Camera.ActiveStatus && camera.focus.isFocusModeSupported(Camera.FocusAuto)
        onClicked: (camera.lockStatus == Camera.Unlocked) ? camera.searchAndLock() : camera.unlock()
      }

      Button {
        property int currentCamera: 0
        property var cameras: QtMultimedia.availableCameras
        text: "Change camera"
        onClicked: {
          if (++currentCamera >= cameras.length) currentCamera = 0
          camera.deviceId = cameras[currentCamera].deviceId
        }
      }
    }
  }

  MediaPlayer {
    id: mediaPlayer
    autoPlay: true
    source: previewVideo.visible ? camera.videoRecorder.actualLocation : ""

    onStatusChanged: {
      if (status == MediaPlayer.EndOfMedia)
        previewVideo.visible = false
    }
  }

  VideoOutput {
    id : previewVideo
    anchors.fill : parent
    visible: false
    source: mediaPlayer

    Rectangle {
      anchors.fill: parent
      color: "black"
      z: -1
    }

    MouseArea {
      anchors.fill: parent
      onClicked: {
        camera.start()
        previewVideo.visible = false
      }
    }
  }
}
