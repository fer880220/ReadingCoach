import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2

ApplicationWindow {
    visible: true

    title: qsTr("Reading Coach")
    header: ToolBar{

    }

    StackView{
            id: stackView
            anchors.fill: parent
            initialItem: PagePortada {}
        }

}
