#include <QGuiApplication>
#include <qplugin.h>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickStyle>
#ifdef Q_OS_MAC
#include "MacTitleBarTransparent.h"
#endif

#include <QtQml/qqml.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Fusion");

    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:/qt/qml/");
    engine.addImportPath(":/qt/qml/");



    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(QUrl(u"qrc:/qml/Main.qml"_qs));


    if (!engine.rootObjects().isEmpty())
    {
        auto window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
#ifdef Q_OS_MAC
        if (window)
            macTitleBarTransparent(window);
#endif


    }

    return app.exec();
}