import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

Page {
    id: page
    background: Rectangle{anchors.fill: parent ; color:"white" /*objAux.background*/}

    Timer {
        id: timer
        interval: 500; running: true; repeat: true
        onTriggered:{
            texto.text = objAux.getNextPack()
        }
    }

    ColorDialog {
        id: colorDialog

        property bool colorBackgr: false

        onAccepted: {
            if(colorBackgr)
                objAux.background = currentColor
            else
                objAux.color = currentColor
        }
        function abrir(fbackground){
            colorBackgr = fbackground
            open()
        }

    }
    FontDialog {

        id: fontDialog
        onAccepted: {
            objAux.font = currentFont
        }

    }
    TextEdit { id: texto
        font: objAux.font
        color: objAux.color
        anchors.centerIn: parent
        width: parent.width * 0.66
        horizontalAlignment: TextEdit.AlignHCenter
        verticalAlignment: TextEdit.AlignVCenter
        wrapMode: TextEdit.Wrap
        visible: false
        renderType:  Text.NativeRendering

    }
    Rectangle{visible: !texto.visible
        width: flick.width; height: flick.height; x: flick.x ; y: flick.y ;
        color:"#47d12c"}
    Flickable {
        id: flick
        visible: !texto.visible
        width: parent.width * 0.66 ; height: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: controles.bottom
        contentWidth: edit.paintedWidth
        contentHeight: edit.paintedHeight
        clip: true
        ScrollBar.vertical: ScrollBar { }




        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }


        TextEdit{
            id:edit
            font.family: "Segooe UI"
            font.pointSize: 15
            width: flick.width
            height: flick.height
            horizontalAlignment: TextEdit.AlignHCenter
            verticalAlignment: TextEdit.AlignVCenter
            focus: true
            wrapMode: TextEdit.Wrap
            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
            renderType:  Text.NativeRendering

            Text{
                visible: edit.text == ""
                font.family: "Segooe UI"
                font.pointSize: 15
                anchors.centerIn: parent
                text: "inserte un texto para comenzar"
                renderType:  Text.NativeRendering
            }
        }

    }



    ColumnLayout{
        id:controles
        spacing: 10
        TextField{
            id: textFiel1
            width: page.width - 20
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            font.family: "Segooe UI"
            font.pointSize: 15
            placeholderText:  "intervalo (ms)"

        }
        TextField{
            id: textFiel2
            width: page.width - 20
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            font.family: "Segooe UI"
            font.pointSize: 15
            placeholderText: "cantidad de palabras"

        }
        RowLayout{
            Button{
                id:bt1
                text: "start"

                Layout.preferredHeight: bt1.width
                onClicked: {
                    objAux.setStr( edit.text )
                    timer.interval = objAux.toFloat( textFiel1.text )
                    var lenFrase = objAux.toFloat( textFiel2.text )
                    objAux.setLenPack( lenFrase )
                    timer.start()
                    texto.visible = true
                    palPerMin.text ="Velocidad: "+
                            parseInt(60000*lenFrase/timer.interval)+ " PPM"
                    btPause.visible = true ; btPause.text = "Pause"
                }
            }
            Button{
                id:btPause
                Layout.preferredHeight: bt1.width
                visible: false
                onClicked: {
                    if( text == "Pause"){
                        timer.stop()
                        text = "Continue"
                    }else{
                        timer.start()
                        text = "Pause"
                    }
                }
            }
            Button{
                Layout.preferredHeight: bt1.width
                text: "Stop"
                onClicked: {timer.stop(); texto.visible = false ; btPause.visible = false ; }
            }
            Button{
                Layout.preferredHeight: bt1.width
                text: "Borrar"
                onClicked: {edit.clear()}
            }
            Button{
                Layout.preferredHeight: bt1.width
                text: "Pegar"
                onClicked: {edit.paste()}
            }
        }
        RowLayout{
            Button{Layout.preferredHeight: bt1.width
                text: "color"
                onClicked: colorDialog.abrir( false )
            }
            Button{Layout.preferredHeight: bt1.width
                text: "font"
                onClicked: fontDialog.open()
            }
           /* Button{Layout.preferredHeight: bt1.width
                text: "fondo"
                onClicked: colorDialog.abrir( true )
            }*/
        }
        RowLayout{
            CheckBox{
                checked: objAux.getReverseStr()
                onClicked: objAux.setReverseStr(checked)
                text: "voltear palabra"
            }
            CheckBox{
                checked: objAux.getReverseSentence()
                onClicked: objAux.setReverseSentence(checked)
                text: "voltear oración"
            }
        }
        Text{
            id:palPerMin
            font.family: "Segooe UI"
            font.pointSize: 15
            renderType: Text.NativeRendering
        }
    }

}
