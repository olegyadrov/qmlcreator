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

#include "ProjectManager.h"

ProjectManager::ProjectManager(QObject *parent) :
    QObject(parent)
{
    QDir().mkpath(baseFolderPath(Projects));
    QDir().mkpath(baseFolderPath(Examples));
}

ProjectManager::BaseFolder ProjectManager::baseFolder()
{
    return m_baseFolder;
}

void ProjectManager::setBaseFolder(BaseFolder baseFolder)
{
    if (m_baseFolder != baseFolder)
    {
        m_baseFolder = baseFolder;
        emit baseFolderChanged();
    }
}

QStringList ProjectManager::projects()
{
    QDir dir(baseFolderPath(m_baseFolder));
    QStringList projects;
    QFileInfoList folders = dir.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot);

    foreach(QFileInfo folder, folders) {
        QString folderName = folder.fileName();
        projects.push_back(folderName);
    }

    return projects;
}

void ProjectManager::createProject(QString projectName)
{
    QDir dir(baseFolderPath(Projects));
    if (dir.mkdir(projectName))
    {
        QFile file(baseFolderPath(Projects) + QDir::separator() + projectName + QDir::separator() + "main.qml");
        if (file.open(QIODevice::WriteOnly | QIODevice::Text))
        {
            QString fileContent = "// Project \"" + projectName + "\"\n" + newFileContent("main");
            QTextStream textStream(&file);
            textStream<<fileContent;
        }
        else
        {
            emit error(QString("Unable to create file \"main.qml\""));
        }
    }
    else
    {
        emit error(QString("Unable to create folder \"%1\".").arg(projectName));
    }
}

void ProjectManager::removeProject(QString projectName)
{
    QDir dir(baseFolderPath(m_baseFolder) + QDir::separator() + projectName);
    dir.removeRecursively();
}

bool ProjectManager::projectExists(QString projectName)
{
    QFileInfo checkFile(baseFolderPath(Projects) + QDir::separator() + projectName);
    return checkFile.exists();
}

void ProjectManager::restoreExamples()
{
    QDir deviceExamplesDir(baseFolderPath(Examples));
    deviceExamplesDir.removeRecursively();
    deviceExamplesDir.mkpath(baseFolderPath(Examples));

    QDir qrcExamplesDir(":/qml/examples");
    QFileInfoList folders = qrcExamplesDir.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot);

    foreach(QFileInfo folder, folders) {
        QString folderName = folder.fileName();
        deviceExamplesDir.mkdir(folderName);

        QDir qrcExampleDir(":/qml/examples/" + folderName);

        QFileInfoList files = qrcExampleDir.entryInfoList(QDir::Files);

        foreach(QFileInfo file, files) {
            QString fileName = file.fileName();
            QFile::copy(file.absoluteFilePath(), baseFolderPath(Examples) + QDir::separator() + folderName + QDir::separator() + fileName);

            QFile::setPermissions(baseFolderPath(Examples) + QDir::separator() + folderName + QDir::separator() + fileName,
                                  QFileDevice::ReadOwner | QFileDevice::WriteOwner |
                                  QFileDevice::ReadUser  | QFileDevice::WriteUser  |
                                  QFileDevice::ReadGroup | QFileDevice::WriteGroup |
                                  QFileDevice::ReadOther | QFileDevice::WriteOther
                                  );
        }
    }
}

QString ProjectManager::projectName()
{
    return m_projectName;
}

void ProjectManager::setProjectName(QString projectName)
{
    if (m_projectName != projectName)
    {
        m_projectName = projectName;
        emit projectNameChanged();
    }
}

QStringList ProjectManager::files()
{
    QDir dir(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName);
    QStringList projectFiles;
    QFileInfoList files = dir.entryInfoList(QDir::Files);

    foreach(QFileInfo file, files) {
        if (file.suffix() == "qml" || file.suffix() == "js")
        {
            QString fileName = file.fileName();
            projectFiles.push_back(fileName);
        }
    }

    return projectFiles;
}

void ProjectManager::createFile(QString fileName, QString fileExtension)
{
    QFile file(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + fileName + "." + fileExtension);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream textStream(&file);
        textStream<<newFileContent(fileExtension);
    }
    else
    {
        emit error(QString("Unable to create file \"%1.%2\"").arg(fileName, fileExtension));
    }
}

void ProjectManager::removeFile(QString fileName)
{
    QDir().remove(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + fileName);
}

bool ProjectManager::fileExists(QString fileName)
{
    QFileInfo checkFile(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + fileName);
    return checkFile.exists();
}

QString ProjectManager::fileName()
{
    return m_fileName;
}

QString ProjectManager::fileFormat()
{
    return m_fileFormat;
}

void ProjectManager::setFileName(QString fileName)
{
    if (m_fileName != fileName)
    {
        QFileInfo fileInfo(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + fileName);

        m_fileName = fileName;
        m_fileFormat = fileInfo.suffix();

        emit fileNameChanged();
        emit fileFormatChanged();
    }
}

QString ProjectManager::getFilePath()
{
    return "file:///" + baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + m_fileName;
}

QString ProjectManager::getFileContent()
{
    QFile file(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + m_fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream textStream(&file);
    QString fileContent = textStream.readAll().trimmed();
    return fileContent;
}

void ProjectManager::saveFileContent(QString content)
{
    QFile file(baseFolderPath(m_baseFolder) + QDir::separator() + m_projectName + QDir::separator() + m_fileName);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream textStream(&file);
    textStream<<content;
}

QQmlApplicationEngine *ProjectManager::m_qmlEngine = NULL;

void ProjectManager::setQmlEngine(QQmlApplicationEngine *engine)
{
    ProjectManager::m_qmlEngine = engine;
}

void ProjectManager::clearComponentCache()
{
    ProjectManager::m_qmlEngine->clearComponentCache();
}

QObject *ProjectManager::projectManagerProvider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    ProjectManager *projectManager = new ProjectManager();
    return projectManager;
}

QString ProjectManager::baseFolderPath(BaseFolder folder)
{
    QString folderName;

    switch (folder)
    {
    case Projects:
        folderName = "Projects";
        break;
    case Examples:
        folderName = "Examples";
        break;
    }

    QString folderPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) +
                         QDir::separator() +
                         "QML Projects";

    if (!folderName.isEmpty())
    {
        folderPath += QDir::separator() + folderName;
    }

    return folderPath;
}

QString ProjectManager::newFileContent(QString fileType)
{
    QString fileName;

    if (fileType == "main")
        fileName = "MainFile.qml";
    else if (fileType == "qml")
        fileName = "QmlFile.qml";
    else if (fileType == "js")
        fileName = "JsFile.js";

    QString fileContent;

    if (!fileName.isEmpty())
    {
        QFile file(":/resources/templates/" + fileName);
        file.open(QIODevice::ReadOnly | QIODevice::Text);
        QTextStream textStream(&file);
        fileContent = textStream.readAll().trimmed();
    }

    return fileContent;
}
