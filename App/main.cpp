#include <QGuiApplication>
#include <qplugin.h>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QQuickStyle>
#include <QLoggingCategory>
#ifdef Q_OS_MAC
#endif
#include <QtQml/qqml.h>
#include <QtCore/QString>
#include <QSGRendererInterface>
#include "SvgIconItem.h"

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    // 진단용: 렌더 루프를 basic으로 고정(단일 스레드)
    qputenv("QSG_RENDER_LOOP", QByteArray("basic"));
    // 추가 진단: Scene Graph 로그
    qputenv("QSG_INFO", QByteArray("1"));


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

    return app.exec();
}
