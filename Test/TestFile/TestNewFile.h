//
// Created by Justmoong on 5/9/25.
//

#pragma once
#include <QTest>

#include <QFile>
#include <QString>
#include <QTextStream>
#include <QDir>
#include <QRandomGenerator>
#include <QDebug>


class TestNewFile: public QObject {
    Q_OBJECT

private:
    quint64 NoteID;
    QString noteHeader;
    QString noteContents;
    QString outputDir;

private slots:
    void initTestCase();
    void testNewNoteHeaderFile();
    void testNewNoteContentsFile();
};