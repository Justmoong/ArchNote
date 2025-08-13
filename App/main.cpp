#include <QGuiApplication>
#include <qplugin.h>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickStyle>
#ifdef Q_OS_MAC
#include "MacTitleBarTransparent.h"
#endif
#include <QtQml/qqml.h>
#include <QtCore/QString>
#include <QSGRendererInterface>
#include "SvgIconItem.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Fusion");

    QQuickWindow::setGraphicsApi(QSGRendererInterface::Metal);

    // QML 타입 등록
    qmlRegisterType<SvgIconItem>("ArchNote", 1, 0, "KSvgIcon");

    QQmlApplicationEngine engine;

    engine.addImportPath("qrc:/qt/qml/");
    engine.addImportPath(":/qt/qml/");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(QUrl(u"qrc:/qml/Main.qml"_s));

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
