import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Layouts
import QtCore
import org.julialang

ApplicationWindow {
    visible: true
    width: 640
    height: 320
    title: "Calibração do Volume de Pinus caribaea hondurensis"

    property string conclusionText: "" // Nova propriedade para armazenar o texto do resultado
    property var bfixo: [1.0, 2.0] // Nova propriedade para armazenar o texto do resultado
    property var best: [1.0, 2.0] // Nova propriedade para armazenar o texto do resultado 

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
            onClicked: {
                var emptyFields = [];

                // Verifique se os campos estão vazios ou contêm apenas espaços em branco
                if (!dap.text || dap.text.trim() === "") {
                    emptyFields.push("Dap");
                }

                if (!h.text || h.text.trim() === "") {
                    emptyFields.push("Altura");
                }

                if (!v.text || v.text.trim() === "") {
                    emptyFields.push("Volume");
                }

                if (emptyFields.length > 0) {
                    // Se houver campos vazios, exiba o diálogo
                    emptyDialog.text = "Ausência de dados nos campos: " + emptyFields.join(", ");
                    emptyDialog.open();
                } else {
                    // Aqui você pode adicionar a lógica para processar os dados inseridos
                    saveDialog.open();
                }
            }
        }
        FileDialog {
            id: saveDialog
            title: "Selecione o arquivo no formato .CSV com os dados a serem processados"
            fileMode: FileDialog.SaveFile
            currentFolder: standardLocations(StandardPaths.HomeLocation)[0]
            onAccepted: {
                var resultado = Julia.vpch(dap.text, h.text, v.text, saveDialog.selectedFile)

                bfixo = resultado[0]
                best = resultado[1]

                root.do_plot(resultado[2]);

                conclusionDialog.open();
            }
            Component.onCompleted: visible = false
        }
        MessageDialog {
            id: conclusionDialog
            title: "Calibração Concluida com Sucesso"
            buttons: MessageDialog.Ok
            text: " Os valores de bfixo são: β0 = " + bfixo[0] + " β1 = " + bfixo[1] + "\nOs valores de estimado são: β0 = " + best[0] + " β1 = " + best[1]
        }
        MessageDialog {
            id: emptyDialog
            title: "Dados insuficientes para Calibração"
            buttons: MessageDialog.Ok
        }
    }
    ColumnLayout {
    id: root
    spacing: 6
    anchors.fill: parent

        function do_plot(def_graph) {
            if(jdisp === null)
            return;

            Julia.plot_result(jdisp, def_graph);
        }

        function init_and_plot(def_graph) {
            if(jdisp === null)
                return;

            Julia.init_backend(jdisp.width, jdisp.height);
            do_plot(def_graph);
        }

        JuliaDisplay {
        id: jdisp
        Layout.fillWidth: true
        Layout.fillHeight: true
        onHeightChanged: root.init_and_plot()
        onWidthChanged: root.init_and_plot()
        }
    }
}
