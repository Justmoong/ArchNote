#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QtSvg/QSvgRenderer>
#include "MacTitleBarTransparent.h"
#include <QtQml/qqml.h>
#include <DSSvg>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    DSSvgImporter::registerProvider(&engine);


    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Qml", "Main");

    if (!engine.rootObjects().isEmpty())
    {
        auto window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        if (window)
        {
            macTitleBarTransparent(window);
        }
    }

    return app.exec();
}
