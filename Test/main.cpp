//
// Created by Justmoong on 5/9/25.
//

#include <QTest>

// QTEST_MAIN(TestClass)

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "TestRegistry.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    registerAllTests(argc, argv);

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.addImportPath("qrc:/qt/qml");
    engine.loadFromModule("TestQml", "Main");

    return app.exec();
}
