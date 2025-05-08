#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlextensionplugin.h>
#include <QtPlugin>

#include "app_environment.h"


int main(int argc, char *argv[])
{
    Q_IMPORT_QML_PLUGIN(ArchNoteAppQmlPlugin)
    Q_IMPORT_QML_PLUGIN(ArchNoteAppQmlViewPlugin)

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ArchNote", "Main");

    return app.exec();
}
