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

#ifndef PROJECTMANAGER_H
#define PROJECTMANAGER_H

#include <QObject>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QIODevice>
#include <QStandardPaths>
#include <QTextStream>
#include <QQmlApplicationEngine>

class ProjectManager : public QObject
{
    Q_OBJECT

    Q_ENUMS(BaseFolder)
    Q_PROPERTY(BaseFolder baseFolder MEMBER m_baseFolder READ baseFolder WRITE setBaseFolder NOTIFY baseFolderChanged)
    Q_PROPERTY(QString projectName MEMBER m_projectName READ projectName WRITE setProjectName NOTIFY projectNameChanged)
    Q_PROPERTY(QString fileName MEMBER m_fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)
    Q_PROPERTY(QString fileFormat MEMBER m_fileFormat READ fileFormat NOTIFY fileFormatChanged)

public:
    explicit ProjectManager(QObject *parent = 0);

    enum BaseFolder { Projects, Examples };

    // project management
    BaseFolder baseFolder();
    void setBaseFolder(BaseFolder baseFolder);
    Q_INVOKABLE QStringList projects();
    Q_INVOKABLE void createProject(QString projectName);
    Q_INVOKABLE void removeProject(QString projectName);
    Q_INVOKABLE bool projectExists(QString projectName);
    Q_INVOKABLE void restoreExamples();

    // current project
    QString projectName();
    void setProjectName(QString projectName);
    Q_INVOKABLE QStringList files();
    Q_INVOKABLE void createFile(QString fileName, QString fileExtension);
    Q_INVOKABLE void removeFile(QString fileName);
    Q_INVOKABLE bool fileExists(QString projectName);

    // current file
    QString fileName();
    QString fileFormat();
    void setFileName(QString fileName);
    Q_INVOKABLE QString getFilePath();
    Q_INVOKABLE QString getFileContent();
    Q_INVOKABLE void saveFileContent(QString content);

    // QML engine stuff
    static void setQmlEngine(QQmlApplicationEngine *engine);
    Q_INVOKABLE void clearComponentCache();

    // singleton type provider function
    static QObject *projectManagerProvider(QQmlEngine *engine, QJSEngine *scriptEngine);

private:
    // project management
    BaseFolder m_baseFolder;
    QString baseFolderPath(BaseFolder folder);
    QString newFileContent(QString fileType);

    // current project
    QString m_projectName;

    // current file
    QString m_fileName;
    QString m_fileFormat;

    // QML engine stuff
    static QQmlApplicationEngine *m_qmlEngine;

signals:
    void baseFolderChanged();
    void projectNameChanged();
    void fileNameChanged();
    void fileFormatChanged();
    void error(QString description);
};

#endif // PROJECTMANAGER_H
