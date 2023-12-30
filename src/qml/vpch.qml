import QtQuickg
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
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

        Row {
            anchors.horizontalCenter: parent.horizontalCenter // Centralizar na horizontal
            y: 50
            spacing: 10

            // Primeira entrada de dados
            TextField {
                id: dap
                placeholderText: qsTr("Dap (cm)")
                horizontalAlignment: Text.AlignHCenter
            }

            // Segunda entrada de dados
            TextField {
                id: h
                placeholderText: qsTr("Altura (m)")
                horizontalAlignment: Text.AlignHCenter
            }

            // Terceira entrada de dados
            TextField {
                id: v
                placeholderText: qsTr("Volume (m³)")
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Botão para processar os dados (opcional)
        Button {
            text: "Processar Dados"
            anchors.horizontalCenter: parent.horizontalCenter // Centralizar na horizontal
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                // Aqui você pode adicionar a lógica para processar os dados inseridos
                Julia.vpch(dap.text, h.text, v.text)
            }
        }
    }
}
