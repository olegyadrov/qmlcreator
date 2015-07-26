/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
** http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
****************************************************************************/

#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#include <QtQuick/QQuickTextDocument>
#include "ProjectManager.h"
#include "SyntaxHighlighter.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("QML Creator");
    app.setApplicationVersion("1.2.3");
    app.setOrganizationName("wearyinside");
    app.setOrganizationDomain("com.wearyinside.qmlcreator");

    qmlRegisterType<ProjectManager>("ProjectManager", 1, 1, "ProjectManager");
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 1, "SyntaxHighlighter");

    QQmlApplicationEngine engine(QUrl("qrc:/qml/main.qml"));
    ProjectManager::setQmlEngine(&engine);

    return app.exec();
}
