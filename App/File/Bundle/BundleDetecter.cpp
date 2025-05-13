//
// Created by Justmoong on 5/13/25.
//
#include "BundleDetecter.h"

BundleDetecter::BundleDetecter(QObject* parent) : QObject(parent)
{
}

void BundleDetecter::setLookingPath(const QString& path)
{
    lookingPath = path;
}

void BundleDetecter::setBundleName(const QString& name)
{
    bundleName = name;
}

BundleDetecter::Result BundleDetecter::detectBundle()
{
    if (lookingPath.isEmpty() || bundleName.isEmpty())
    {
        QWarning() << "no such bundle";
        return Result::BundleNotFound;
    }

    Qdir bundleDir(lookingPath);
    if (!bundleDir.exists(bundleName))
    {
        qDebug() << "bundle not found at path: " << QDir(lookingPath).filePath(bundleName);
        return Result::BundleNotFound;
    }

    QDir fullBundlePath(bundleDir.filePath(bundleName));
    if (!fullBundlePath.exists())
    {
        qDebug() << "bundle not found at path: " << fullBundlePath.path();
        return Result::BundleNotFound;
    }

    QString headerPath = fullBundlePath.filePath(expectedHeader);
    QFile headerFile(headerPath);

    if (!headerFile.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qWarning() << "file is read only" << headerPath;
        return Result::BundleNotFound;
    }

    if (!headerFile.exists())
    {
        qDebug() << "header is not found at bundle: " << headerPath;
        return Result::NotArchNoteBundle;
    }

    QTextStream in(&headerFile);
    QString line = in.readLine(); //readAll();
    headerFile.close();

    if (!line.startsWith(expectedIdentifier))
    {
        qDebug() << "bundle is damaged" << headerPath;
    }

    qInfo() << "found bundle: " << bundleName << "at path: " << fullBundlePath.path();
    return Result::ValidBundle;
}

QString BundleDetecter::getBundleName() const
{
    return bundleName;
}

?
