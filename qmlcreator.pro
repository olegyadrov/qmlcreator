QT += \
    core gui qml quick \
    multimedia sql \
    network websockets \
    xml svg \
    sensors bluetooth nfc \
    positioning location \
    3dcore 3drenderer 3dinput 3dquick

TARGET = qmlcreator
TEMPLATE = app

CONFIG += mobility
MOBILITY =

RESOURCES += \
    qmlcreator_resources.qrc

HEADERS += \
    cpp/ProjectManager.h \
    cpp/QMLHighlighter.h \
    cpp/SyntaxHighlighter.h \
    cpp/MessageHandler.h

SOURCES += \
    cpp/main.cpp \
    cpp/ProjectManager.cpp \
    cpp/QMLHighlighter.cpp \
    cpp/SyntaxHighlighter.cpp \
    cpp/MessageHandler.cpp

lupdate_only {
SOURCES += \
    qml/components/*.qml \
    qml/components/dialogs/*.qml \
    qml/components/palettes/*.qml \
    qml/modules/*.qml \
    qml/screens/*.qml \
    qml/*.qml
}

TRANSLATIONS = resources/translations/qmlcreator_ru.ts

android {
    OTHER_FILES += platform-specific/android/AndroidManifest.xml
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/platform-specific/android
}

ios {
    ICON_DATA.files = \
        $$PWD/platform-specific/ios/Icon.png \
        $$PWD/platform-specific/ios/Icon@2x.png \
        $$PWD/platform-specific/ios/Icon-60.png \
        $$PWD/platform-specific/ios/Icon-60@2x.png \
        $$PWD/platform-specific/ios/Icon-72.png \
        $$PWD/platform-specific/ios/Icon-72@2x.png \
        $$PWD/platform-specific/ios/Icon-76.png \
        $$PWD/platform-specific/ios/Icon-76@2x.png \
        $$PWD/platform-specific/ios/Def.png \
        $$PWD/platform-specific/ios/Def@2x.png \
        $$PWD/platform-specific/ios/Def-Portrait.png \
        $$PWD/platform-specific/ios/Def-568h@2x.png
    QMAKE_BUNDLE_DATA += ICON_DATA

    QMAKE_INFO_PLIST = $$PWD/platform-specific/ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}
