#include <QGuiApplication>
#include <qplugin.h>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickStyle>
#include <QtPlugin>
#include "MacTitleBarTransparent.h"
#include <QtQml/qqml.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Fusion");

    QQmlApplicationEngine engine;

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
