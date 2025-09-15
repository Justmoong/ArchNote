#include <QGuiApplication>
#include <qplugin.h>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QLoggingCategory>
#include <QtQml/qqml.h>
#include <QtCore/QString>
#include <QSGRendererInterface>
#include <QQmlContext>
#include <QDir>
#include <QByteArray>
#include <QRegularExpression>

#include <KLocalizedString>
#include <KLocalizedContext>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // Add optional import paths from CMake definition and environment variables
    auto addImportPaths = [&](const QStringList &paths) {
        for (const auto &p : paths) {
            if (!p.isEmpty()) {
                engine.addImportPath(p);
            }
        }
    };

#ifdef ARCHNOTE_DEV_QML_IMPORTS
    {
        const QString macroPaths = QStringLiteral(ARCHNOTE_DEV_QML_IMPORTS);
        const QStringList parts = macroPaths.split(QRegularExpression(u"[:;]"_s), Qt::SkipEmptyParts);
        addImportPaths(parts);
    }
#endif

    auto addFromEnv = [&](const char *name) {
        const QByteArray v = qgetenv(name);
        if (!v.isEmpty()) {
            const QString s = QString::fromLocal8Bit(v);
            const QStringList parts = s.split(QRegularExpression(u"[:;]"_s), Qt::SkipEmptyParts);
            addImportPaths(parts);
        }
    };
    // Prefer project-specific variable; also honor common Qt variables for convenience
    addFromEnv("ARCHNOTE_QML_IMPORTS");
    addFromEnv("QML_IMPORT_PATH");
    addFromEnv("QML2_IMPORT_PATH");
    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(QUrl(u"qrc:/qml/Main.qml"_s));

    return app.exec();
}
