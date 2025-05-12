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

    return 0;
}
