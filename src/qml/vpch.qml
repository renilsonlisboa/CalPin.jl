import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import QtQuick.Dialogs 6.5
import Qt.labs.platform
import org.julialang

ApplicationWindow {
    visible: true
    width: 640
    height: 320
    title: "Calibração do Volume de Pinus caribaea hondurensis"

    Rectangle {
        anchors.fill: parent

        // Defina variáveis para armazenar os dados dos campos de texto
        Image {
            id: backgroundImage
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
            fillMode: Image.Stretch
        }

        Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 75
                    spacing: 10

                    // Estilo para a entrada de dados Dap
                    TextField {
                        id: dap
                        placeholderText: qsTr("Dap (cm)")
                        width: 120
                        height: 30
                        font.pixelSize: 14
                        background: Rectangle {
                            color: "white"
                            border.color: "darkgray"
                            border.width: 1
                            radius: 5
                        }
                        horizontalAlignment: TextInput.AlignHCenter
                    }

                    // Estilo para a entrada de dados Altura
                    TextField {
                        id: h
                        placeholderText: qsTr("Altura (m)")
                        width: 120
                        height: 30
                        font.pixelSize: 14
                        background: Rectangle {
                            color: "white"
                            border.color: "darkgray"
                            border.width: 1
                            radius: 5
                        }
                        horizontalAlignment: TextInput.AlignHCenter
                    }

                    // Estilo para a entrada de dados Volume
                    TextField {
                        id: v
                        placeholderText: qsTr("Volume (m³)")
                        width: 120
                        height: 30
                        font.pixelSize: 14
                        background: Rectangle {
                            color: "white"
                            border.color: "darkgray"
                            border.width: 1
                            radius: 5
                        }
                        horizontalAlignment: TextInput.AlignHCenter
                    }
                }

        // Botão para calibrar os dados (opcional)
        Button {
            text: "Calibrar"
            anchors.centerIn: parent
            padding: 10
            font.bold: true
            font.pixelSize: 16
            anchors.verticalCenterOffset: 50
            background: Rectangle {
                color: "orange"
                radius: 5
                width: parent.width
                height: parent.height
            }
            onClicked: {
                // Aqui você pode adicionar a lógica para processar os dados inseridos
                Julia.vpch(dap.text, h.text, v.text)
            }
        }
    }
}
