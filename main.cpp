#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "chat.h"

#ifdef Q_OS_ANDROID
#include "keepAwakeChecker.h"
#endif

int main(int argc, char *argv[])
{

#ifdef Q_OS_ANDROID
    KeepAwakeChecker keepAwakeChecker;
#endif

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    Chat chat;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("chat", &chat);
    engine.rootContext()->setContextProperty("keepAwakeChecker", &keepAwakeChecker);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
