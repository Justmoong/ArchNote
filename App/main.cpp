#include <QGuiApplication>
#include <qplugin.h>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QLoggingCategory>
#include <QtQml/qqml.h>
#include <QtCore/QString>
#include <QSGRendererInterface>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(QUrl(u"qrc:/qml/Main.qml"_s));

    return app.exec();
}
