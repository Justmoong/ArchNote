//
// Created by Justmoong on 5/9/25.
//
#include "TestRegistry.h"

#include "TestFile/TestNewFile.h"
#include "TestFile/TestIDGen.h"


void registerAllTests(int argc, char *argv[]) {
    int result = 0;
    result |= QTest::qExec(new TestNewFile, argc, argv);
    result |= QTest::qExec(new TestIDGen, argc, argv);


    if (result != 0) {
        qWarning() << "Some tests failed";
        exit(result);
    }
}