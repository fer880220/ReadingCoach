import QtQuick 2.8
import QtQuick.Controls 2.1


Page {
    Image{
        anchors.fill: parent
        source: "qrc:/portada.png"

        MouseArea{
            anchors.fill: parent
            onClicked:stackView.push("qrc:/Page1.qml")
        }
    }
}
