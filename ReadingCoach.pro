TEMPLATE = app

QT += qml quick quickcontrols2 widgets

CONFIG += c++11

SOURCES += main.cpp \
    auxiliar.cpp

HEADERS += auxiliar.h

RESOURCES += qml.qrc

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/res/values/libs.xml \
    android/gradle/wrapper/gradle-wrapper.properties

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android







