import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.platform
import org.julialang

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Calibração da Altura do Pinus taeda"

    Grid {
        id: gridLayout
        columns: 3
        anchors.centerIn: parent
        spacing: 10

        // Adicione 21 campos de entrada (TextField)
        Repeater {
            model: 21
            TextField {
                placeholderText: qsTr("Dado")
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Botão para processar os dados
        Button {
            text: "Processar Dados"
            Layout.rowSpan: 7 // Estende-se por 7 linhas
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

                console.log("Vetores de valores por coluna: " + JSON.stringify(columnVectors));

                // Substitua o console.log pela chamada à função Julia.vpch com os dados necessários
            }
        }
    }
}
