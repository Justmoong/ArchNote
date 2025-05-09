//
// Created by Justmoong on 5/9/25.
//

#include "TestIDGen.h"

void TestIDGen::testNewIDGen()
{
    const QString charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const int length = 32;

    QString result;
    result.reserve(length);

    for (int i = 0; i < length; ++i) {
        int index = QRandomGenerator::global()->bounded(charset.size());
        result.append(charset.at(index));
    }

    RandomID = result;
    qDebug() << "Generated ID:" << RandomID;
}