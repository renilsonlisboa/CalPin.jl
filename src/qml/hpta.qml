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
    height: 480
    title: "Calibração da Altura do Pinus taeda"

    property string conclusionText: "" // Nova propriedade para armazenar o texto do resultado
    property var bfixo: [1.0, 2.0] // Nova propriedade para armazenar o texto do resultado
    property var best: [1.0, 2.0] // Nova propriedade para armazenar o texto do resultado

    // Defina variáveis para armazenar os dados dos campos de texto
    Image {
        id: backgroundImage
        source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
    }

    Grid {
        id: gridLayout
        columns: 2
        anchors.centerIn: parent
        spacing: 10

        // Adicione 21 campos de entrada (TextField)
        Repeater {
            model: 18
            TextField {
                placeholderText: (index % 2 === 0) ? "Dap (cm)" :
                                 (index % 2 === 1) ? "Altura (m)" : ""
                horizontalAlignment: Text.AlignHCenter
                width: 120
                height: 30
                font.pixelSize: 14
            }
        }

        FileDialog {
            id: saveDialog
            title: "Selecione o arquivo no formato .CSV com os dados a serem processados"
            fileMode: FileDialog.SaveFile
            currentFolder: standardLocations(StandardPaths.HomeLocation)[0]
            onAccepted: {
                var columnVectors = [];

                // Inicializa vetores para cada coluna
                for (var i = 0; i < gridLayout.columns; i++) {
                    columnVectors.push([]);
                }

                // Itera pelos filhos do GridLayout
                for (var j = 0; j < gridLayout.children.length; j++) {
                    // Adiciona os valores dos TextField aos vetores correspondentes
                    if (gridLayout.children[j] instanceof TextField) {
                        var columnIndex = j % gridLayout.columns;
                        columnVectors[columnIndex].push(gridLayout.children[j].text);
                    }
                }

                if (columnVectors.length < 18) {
                    emptyDialog.open();
                } else {

                    var resultado = Julia.hpta(columnVectors, saveDialog.selectedFile)

                    bfixo = resultado[0]
                    best = resultado[1]

                    conclusionDialog.open();
                }
            }
            Component.onCompleted: visible = false
        }
        MessageDialog {
            id: conclusionDialog
            title: "Calibração Concluida com Sucesso"
            buttons: MessageDialog.Ok
            text: " Coeficientes estimados, parte aleatória \nβ0 = " + bfixo[0] + "\nβ1 = " + bfixo[1] + "\n\nCoeficientes calibrados \nβ0 = " + best[0] + "\nβ1 = " + best[1]
        }
        MessageDialog {
            id: emptyDialog
            title: "Dados insuficientes para Calibração"
            text: "Os dados informados são insuficientes para a calibração.\nPreencha todos os campos e tente novamente."
            buttons: MessageDialog.Ok
        }
    }
    // Botão para processar os dados
    Button {
        id: calibra
        text: "Calibrar Dados"
        padding: 10
        width: 250
        anchors.centerIn: gridLayout
        anchors.verticalCenterOffset: 200
        font.bold: true
        font.pixelSize: 12
        Layout.rowSpan: 9 // Estende-se por 9 linhas
        Layout.columnSpan: 2// Estende-se por 2 colunas
        onClicked: {
            saveDialog.open()
        }
    }
}
