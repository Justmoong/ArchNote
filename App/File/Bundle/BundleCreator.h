#pragma once

#include <QObject>
#include <QQmlEngine>
#inclide <QFile>
#include <QDir>


//QT_BEGIN_NAMESPACE
//namespace Ui { class BundleCreator; }
//QT_END_NAMESPACE

class BundleCreator : public QObject
{
    Q_OBJECT
    QML_ELEMENT

private:

public:
    explicit BundleCreator(QObject* parent = nullptr);

signals:

private slots:
};

