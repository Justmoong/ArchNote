//
// Created by Justmoong on 5/9/25.
//

#pragma once
#include <QTest>

#include <QRandomGenerator>
#include <QString>

class TestIDGen: QObject {
    Q_OBJECT

private:
    QString RandomID;

private slots:
    void testIDGen();

};
