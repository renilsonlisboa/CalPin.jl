import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "CalPin"
    maximumHeight: height
    maximumWidth: width

    Rectangle {
        id: retangulo
        visible: true
        width: parent.width
        height: parent.height

        Image {
            id: backgroundImage
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
            fillMode: Image.Stretch
        }

        ComboBox {
            id: comboBox
            anchors.centerIn: parent
            width: 480
            anchors.verticalCenterOffset: -75
            height: 30
            currentIndex: 0

            model: ListModel {
                ListElement {
                    text: "Altura"
                }
                ListElement {
                    text: "Volume"
                }
            }

            // Usar um ItemDelegate personalizado para centralizar o texto
            delegate: ItemDelegate {
                width: comboBox.width
                height: comboBox.height

                contentItem: Text {
                    text: model.text
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            // Conectar a função de atualização ao sinal currentIndexChanged
            onCurrentIndexChanged: {
                updateComboBox2();
            }
        }

        ComboBox {
            id: comboBox2
            anchors.centerIn: parent
            width: 480
            anchors.verticalCenterOffset: 25
            height: 30
            currentIndex: 0

            property var alturaOptions: ListModel {
                id: alturaOptions
                ListElement { text: "Pinus maximinoi" }
                ListElement { text: "Pinus taeda" }
            }

            property var volumeOptions: ListModel {
                id: volumeOptions
                ListElement { text: "Pinus caribaea hondurensis" }
                ListElement { text: "Pinus taeda" }
            }

            // Usar um ItemDelegate personalizado para centralizar o texto
            delegate: ItemDelegate {
                width: comboBox.width
                height: comboBox.height

                contentItem: Text {
                    text: model.text
                    anchors.centerIn: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    // Adicionar itálico para "Pinus taeda"
                    font.italic: true
                }
            }

            Component.onCompleted: {
                updateComboBox2();
            }
        }

        Button {
            text: qsTr("Iniciar Calibração")
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 150
            onClicked: {
                if (comboBox.currentIndex === 0
                        && comboBox2.currentIndex === 0) {
                    var hpmawindow = Qt.createComponent("hpma.qml")
                    if (hpmawindow.status === Component.Ready) {
                        var hpmawindowObject = hpmawindow.createObject(parent)

                        // Mostre a nova janela
                        hpmawindowObject.show()
                    }
                } else if (comboBox.currentIndex === 0
                           && comboBox2.currentIndex === 1) {
                    var hptawindow = Qt.createComponent("hpta.qml")
                    if (hptawindow.status === Component.Ready) {
                        var hptawindowObject = hptawindow.createObject(parent)

                        // Mostre a nova janela
                        hptawindowObject.show()
                    }
                } else if (comboBox.currentIndex === 1
                           && comboBox2.currentIndex === 0) {
                    var vpchwindow = Qt.createComponent("vpch.qml")
                    if (vpchwindow.status === Component.Ready) {
                        var vpchwindowObject = vpchwindow.createObject(parent)

                        // Mostre a nova janela
                        vpchwindowObject.show()
                    }
                } else if (comboBox.currentIndex === 1
                           && comboBox2.currentIndex === 1) {
                    var vptawindow = Qt.createComponent("vpta.qml")
                    if (vptawindow.status === Component.Ready) {
                        var vptawindowObject = vptawindow.createObject(parent)

                        // Mostre a nova janela
                        vptawindowObject.show()
                    }
                }
            }
        }
    }
    function updateComboBox2() {
        comboBox2.model = comboBox.currentIndex === 0 ? alturaOptions : volumeOptions;
    }
}
