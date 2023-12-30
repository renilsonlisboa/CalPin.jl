import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform
import org.julialang

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "CalPin"

    Rectangle {
        anchors.fill: parent

        Image {
            id: backgroundImage
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
            fillMode: Image.Stretch
        }

        Column {
            anchors.centerIn: parent
            spacing: 10

            Button {
                text: "Volume Pinus caribaea hondurensis"
                anchors.horizontalCenter: parent.horizontalCenter
                width: implicitWidth
                font.italic: true
                onClicked: {
                    // Adicione a lógica aqui
                    var vpchwindow = Qt.createComponent("vpch.qml")
                    if (vpchwindow.status === Component.Ready) {
                        var vpchwindowObject = vpchwindow.createObject(parent);

                      // Mostre a nova janela
                      vpchwindowObject.show();
                  } else {
                      console.error("Falha ao criar a nova janela:", vpchwindow.errorString());
                  }
                }
            }
            Button {
                text: "Volume Pinus taeda"
                anchors.horizontalCenter: parent.horizontalCenter
                width: implicitWidth
                font.italic: true
                onClicked: {
                    // Adicione a lógica aqui
                    var vptawindow = Qt.createComponent("vpta.qml")
                    if (vptawindow.status === Component.Ready) {
                        var vptawindowObject = vptawindow.createObject(parent);

                      // Mostre a nova janela
                      vptawindowObject.show();
                  } else {
                      console.error("Falha ao criar a nova janela:", vptawindow.errorString());
                  }
                }
            }
            Button {
                text: "Altura Pinus taeda"
                anchors.horizontalCenter: parent.horizontalCenter
                width: implicitWidth
                font.italic: true
                onClicked: {
                    // Adicione a lógica aqui
                    var hptawindow = Qt.createComponent("hpta.qml")
                    if (hptawindow.status === Component.Ready) {
                        var hptawindowObject = hptawindow.createObject(parent);

                      // Mostre a nova janela
                      hptawindowObject.show();
                  } else {
                      console.error("Falha ao criar a nova janela:", hptawindow.errorString());
                  }
                }
            }
            Button {
                text: "Altura Pinus maximinoi"
                anchors.horizontalCenter: parent.horizontalCenter
                width: implicitWidth
                font.italic: true
                onClicked: {
                    // Adicione a lógica aqui
                    var hpmawindow = Qt.createComponent("hpma.qml")
                    if (hpmawindow.status === Component.Ready) {
                        var hpmawindowObject = hpmawindow.createObject(parent);

                      // Mostre a nova janela
                      hpmawindowObject.show();
                  } else {
                      console.error("Falha ao criar a nova janela:", hpmawindow.errorString());
                  }
                }
            }
            Button {
                text: "Sair"
                anchors.horizontalCenter: parent.horizontalCenter
                width: implicitWidth
                font.italic: true
                onClicked: {
                    // Adicione a lógica aqui
                    Qt.quit()
                }
            }
        }
    }
}
