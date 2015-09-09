#ifndef MESSAGEHANDLER_H
#define MESSAGEHANDLER_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTextStream>

class MessageHandler : public QObject
{
    Q_OBJECT

public:
    explicit MessageHandler(QObject *parent = 0);

    // QML engine stuff
    static void setQmlEngine(QQmlApplicationEngine *engine);

    static void handler(QtMsgType messageType, const QMessageLogContext &context, const QString &message);

private:
    // QML engine stuff
    static QQmlApplicationEngine *m_qmlEngine;

    static QObject *m_qmlMessageHandler;
};

#endif // MESSAGEHANDLER_H
