#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "auxiliar.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);


    QQmlApplicationEngine engine;

    QQmlContext* context = engine.rootContext();
    Auxiliar aux ;
    context->setContextProperty("objAux", &aux );

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}


