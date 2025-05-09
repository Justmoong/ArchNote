//
// Created by Justmoong on 5/9/25.
//

#include <QTest>

// QTEST_MAIN(TestClass)

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "TestFile/TestNewFile.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    TestNewFile test;
    int testResult = QTest::qExec(&test, argc, argv);
    if (testResult != 0) {
        qWarning() << "Failed to run tests, QMLEngine does not running.";
        return testResult;
    }

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TestQml", "Main");

    return app.exec();
}
