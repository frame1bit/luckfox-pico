#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <sources/devicecommunication.h>
#include <sources/data.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Data *app_data = new Data();
    DeviceCommunication *devcom = new DeviceCommunication();

    engine.rootContext()->setContextProperty("device", devcom);
    engine.rootContext()->setContextProperty("app_data", app_data);
    qmlRegisterSingletonType(QUrl(QStringLiteral("qrc:/Style.qml")), "Style", 1, 0, "Style");
    //qmlRegisterSingletonType<Data>("Style", 1, 0, "Style", Data::instance);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
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
