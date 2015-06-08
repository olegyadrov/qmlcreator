import QtQuick 2.4
import QtQuick.Window 2.2

Column {
  anchors.centerIn: parent

  Text {
    text: "Version: " + OpenGLInfo.majorVersion + "." + OpenGLInfo.minorVersion
  }

  Text {
    text: if (OpenGLInfo.profile === OpenGLInfo.NoProfile)
            "No Profile";
          else if (OpenGLInfo.profile === OpenGLInfo.CoreProfile)
            "Core Profile";
          else if (OpenGLInfo.profile === OpenGLInfo.CompatibilityProfile)
            "Compatibility Profile"
  }

  Text {
    text: if (OpenGLInfo.renderableType === OpenGLInfo.Unspecified)
            "Renderable Type: Unspecified"
          else if (OpenGLInfo.renderableType === OpenGLInfo.OpenGL) "Renderable Type: OpenGL"
          else if (OpenGLInfo.renderableType === OpenGLInfo.OpenGLES) "Renderable Type: OpenGLES"
  }
}
