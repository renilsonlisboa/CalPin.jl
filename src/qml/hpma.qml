import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform
import org.julialang

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Calibração do Volume do Pinus taeda"

    // Defina variáveis para armazenar os dados dos campos de texto
    Image {
        id: backgroundImage
        source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
    }

    Grid {
        id: gridLayout
        columns: 3
        anchors.centerIn: parent
        spacing: 10

        // Adicione 21 campos de entrada (TextField)
        Repeater {
            model: 27
            TextField {
                placeholderText: (index % 3 === 0) ? "Dap (cm)" :
                                (index % 3 === 1) ? "Altura (m)" :
                                (index % 3 === 2) ? "Volume (m³)" : ""
                horizontalAlignment: Text.AlignHCenter
                width: 120
                height: 30
                font.pixelSize: 14
                background: Rectangle {
                    color: "white"
                    border.color: "darkgray"
                    border.width: 1
                    radius: 5
                }
            }
        }

        // Botão para processar os dados
        Button {
            text: "Processar Dados"
            Layout.rowSpan: 9 // Estende-se por 7 linhas
            Layout.columnSpan: 3 // Estende-se por 3 colunas
            onClicked: {
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

                Julia.vpta(columnVectors[0])


                // Substitua o console.log pela chamada à função Julia.vpch com os dados necessários
            }
        }
    }
}
