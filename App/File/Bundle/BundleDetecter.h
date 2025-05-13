//
// Created by Justmoong on 5/13/25.
//

#pragma once
#include <QTest>
#include <QObject>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QDebug>

class BundleDetecter : public QObject
{
    Q_OBJECT

private:
    QString lookingPath = QDir::homePath();
    QString bundleName;
    const QString expectedHeader = "bundle.header";
    const QString expectedIdentifier = "Bundle Identifier: an";

public:
    explicit BundleDetecter(QObject* parent = nullptr);

    void setLookingPath(const QString& path);
    void setBundleName(const QString& name);

    enum class Result
    {
        BundleNotFound,
        NotArchNoteBundle,
        ValidBundle
    };

    Result detectBundle();

    QString getBundleName() const;
};
