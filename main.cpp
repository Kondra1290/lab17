#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "dbmanager.h"
#include "listmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<ListModel>("ListModel", 0, 1, "ListModel");

    DBManager database;
    database.connectToDataBase();

    ListModel model;
    engine.rootContext()->setContextProperty("myModel", &model);
    engine.rootContext()->setContextProperty("sqlitedatabase", &database);

    const QUrl url(QStringLiteral("qrc:/LAb17/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
