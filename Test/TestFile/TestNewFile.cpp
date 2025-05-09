//
// Created by Justmoong on 5/9/25.
//
#include "TestNewFile.h"

#include "../../../../Qt-6.8.3-static-install/lib/QtTest.framework/Versions/A/Headers/qtestcase.h"

void TestNewFile::initTestCase()
{
    NoteID = QRandomGenerator::global()->bounded(quint64(1000000000000000));
    noteHeader = "Placeholder Header";
    noteContents = "# Placeholder markdown Coentents";
    outputDir = "TestNewFile/note_" + QString::number(NoteID);;
    QDir().mkpath(outputDir);
}

void TestNewFile::testNewNoteHeaderFile()
{
    QString headerOutputDir = outputDir + "/Header" + QString::number(NoteID) + ".noteheader";
    QFile file(headerOutputDir);
    QVERIFY2(file.open(QIODevice::WriteOnly | QIODevice::Text), "Could not open header file");

    QTextStream out(&file);
    out << noteHeader;
    file.close();

    QVERIFY2(QFile::exists(headerOutputDir), "Header file does not exist");
}


void TestNewFile::testNewNoteContentsFile()
{
    QString contentsOutputDir = outputDir + "/Contents" + QString::number(NoteID) + ".md";
    QFile file(contentsOutputDir);
    QVERIFY2(file.open(QIODevice::WriteOnly | QIODevice::Text), "Could not open contents file");

    QTextStream out(&file);
    out << noteContents;
    file.close();

    QVERIFY2(QFile::exists(contentsOutputDir), "Contents file does not exist");
}

