import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import QtQuick.Dialogs 6.5
import org.julialang

ApplicationWindow {
    id: mainAPP
    title: "CalPin"
    width: 780
    height: 640
    x: (Screen.width - width) / 2 // Centralizar horizontalmente
    y: (Screen.height - height) / 2 // Centralizar verticalmente
    visible: true

    // Define as váriveis globais para uso no APP
    property string conclusionText: "" // Nova propriedade para armazenar o texto do resultado
    property var bfixo: [1.0, 2.0] // Nova propriedade para armazenar o texto do resultado
    property var best: [1.0, 2.0] // Nova propriedade para armazenar o texto do resultado
    property var columnVectorsVals: []

    // Cria um retangulo para servir de base para inserir os demais objetos
    Rectangle {
        id: retangulo
        visible: true
        width: parent.width
        height: parent.height

        // Importa uma imagem para servir de background
        Image {
            id: backgroundImage
            width: parent.width
            height: parent.height
            opacity: 0.85
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
            fillMode: Image.Stretch
        }

        // Lista com as variáveis passiveis de serem utilizadas
        ComboBox {
            id: comboBox
            anchors.centerIn: parent
            width: 300
            anchors.verticalCenterOffset: -80
            height: 40
            currentIndex: 0

            // Utilizando contentItem para personalizar o texto
            contentItem: Text {
                text: comboBox.currentText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.family: "Arial"
                font.pointSize: 14
            }

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
                    font.family: "Arial"
                    font.pointSize: 14
                    padding: 10
                    font.bold: true
                }
            }

            Connections {
                target: comboBox
                // Conectar a função de atualização ao sinal currentIndexChanged
                onCurrentIndexChanged: {
                    updateComboBox2()
                }
            }
        }

        // Lista com as espécies disponíveis para cada variável
        ComboBox {
            id: comboBox2
            anchors.centerIn: parent
            width: 300
            anchors.verticalCenterOffset: 0
            height: 40
            currentIndex: 0

            property var alturaOptions: ListModel {
                id: alturaOptions
                ListElement {
                    text: "Pinus maximinoi"
                }
                ListElement {
                    text: "Pinus taeda"
                }
            }

            property var volumeOptions: ListModel {
                id: volumeOptions
                ListElement {
                    text: "Pinus caribaea hondurensis"
                }
                ListElement {
                    text: "Pinus taeda"
                }
            }

            contentItem: Text {
                text: comboBox2.currentText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                font.family: "Arial"
                font.italic: true
                font.bold: true
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
                    padding: 10
                    font.bold: true
                    font.pointSize: 14
                    font.family: "Arial"
                    font.italic: true
                }
            }

            Connections {
                target: comboBox2
                Component.onCompleted: {
                    updateComboBox2()
                }
            }
        }

        // Botão para início da calibração
        Button {
            text: qsTr("Iniciar Calibração")
            width: 220
            height: 40
            padding: 10
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 140
            font.family: "Arial"
            font.bold: true
            font.pointSize: 14

            Connections {
                onClicked: {
                    if (comboBox.currentIndex === 0
                            && comboBox2.currentIndex === 0) {
                        windowHPMA.visible = true
                        mainAPP.visible = false
                    } else if (comboBox.currentIndex === 0
                               && comboBox2.currentIndex === 1) {
                        windowHPTA.visible = true
                        mainAPP.visible = false
                    } else if (comboBox.currentIndex === 1
                               && comboBox2.currentIndex === 0) {
                        windowVPCH.visible = true
                        mainAPP.visible = false
                    } else if (comboBox.currentIndex === 1
                               && comboBox2.currentIndex === 1) {
                        windowVPTA.visible = true
                        mainAPP.visible = false
                    }
                }
            }
        }
    }

    // Tela secundária para calibração HPMA
    Window {
        id: windowHPMA
        title: "Calibração da Altura do Pinus maximinoi"
        width: 780
        height: 640
        x: (Screen.width - width) / 2 // Centralizar horizontalmente
        y: (Screen.height - height) / 2 // Centralizar verticalmente
        visible: false

        // Imagem usada como background
        Image {
            id: backgroundImageHPMA
            width: parent.width
            height: parent.height
            opacity: 0.85
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
            fillMode: Image.Stretch
        }

        // Define uma "grade" para inserir as entradas de dados de forma ordenada
        Grid {
            id: gridLayoutHPMA
            columns: 2
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -50
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

            // Abre o dialogo para seleção do local para salvar o arquivo de resultado
            FileDialog {
                id: saveDialogHPMA
                title: "Selecione o local para salvar o arquivo..."
                fileMode: FileDialog.SaveFile

                Connections {
                    target: saveDialogHPMA
                    onAccepted: {
                        var resultado = Julia.hpta(columnVectorsVals,
                                                   saveDialogHPMA.selectedFile)
                        bfixo = resultado[0]
                        best = resultado[1]
                        conclusionDialogHPMA.open()
                        busyIndicatorHPMA.running = false
                    }
                }

                Component.onCompleted: visible = false
            }

            // Abre o dialogo de conclusão da calibração
            MessageDialog {
                id: conclusionDialogHPMA
                title: "Calibração Concluida com Sucesso"
                buttons: MessageDialog.Ok
                text: "Coeficientes estimados, parte aleatória \nb0 = " + bfixo[0] + "\nb1 = " + bfixo[1] + "\n\nCoeficientes calibrados \nβ0 = " + best[0] + "\nβ1 = " + best[1]
            }

            // Abre o dialogo EMPTY quando algum dado não foi informado para calibração
            MessageDialog {
                id: emptyDialogHPMA
                title: "Dados insuficientes para Calibração"
                text: "Os dados informados são insuficientes para a calibração.\nPreencha todos os campos e tente novamente."
                buttons: MessageDialog.Ok
            }
        }

        BusyIndicator {
            id: busyIndicatorHPMA
            width: 120
            height: 120
            running: false
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 250
        }

        // Botão de calibraçãod do HPMA
        Button {
            id: calibraHPMA
            text: "Calibrar Dados"
            padding: 10
            width: 250
            height: 30
            anchors.centerIn: gridLayoutHPMA
            anchors.verticalCenterOffset: 200
            font.family: "Arial"
            font.bold: true
            font.pointSize: 14

            font.pixelSize: 14
            Layout.rowSpan: 9 // Estende-se por 9 linhas
            Layout.columnSpan: 2 // Estende-se por 2 colunas

            Connections {
                target: calibraHPMA
                onClicked: {

                    busyIndicatorHPMA.running = true

                    var columnVectors = []

                    // Inicializa vetores para cada coluna
                    for (var i = 0; i < gridLayoutHPMA.columns; i++) {
                        columnVectors.push([])
                    }

                    // Itera pelos filhos do GridLayout
                    for (var j = 0; j < gridLayoutHPMA.children.length; j++) {
                        // Adiciona os valores dos TextField aos vetores correspondentes
                        if (gridLayoutHPMA.children[j] instanceof TextField) {
                            var columnIndex = j % gridLayoutHPMA.columns
                            var textValue = gridLayoutHPMA.children[j].text.trim()
                            // Remove espaços em branco

                            // Verifica se o valor é vazio ou nulo
                            if (textValue === "") {
                                emptyDialogHPMA.open()
                                return
                                // Aborta o processamento se dados estiverem faltando
                            }

                            columnVectors[columnIndex].push(textValue)
                        }
                    }
                    columnVectorsVals = columnVectors
                    saveDialogHPMA.open()
                }
            }
        }
        Connections {
            target: windowHPMA
            onClosing: mainAPP.visible = true
        }
    }

    Window {
        id: windowHPTA
        title: "Calibração da Altura do Pinus taeda"
        width: 780
        height: 640
        x: (Screen.width - width) / 2 // Centralizar horizontalmente
        y: (Screen.height - height) / 2 // Centralizar verticalmente
        visible: false

        // Imagem usada como background
        Image {
            id: backgroundImageHPTA
            width: parent.width
            height: parent.height
            opacity: 0.9
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
            fillMode: Image.Stretch
        }

        // Define um GRID para organização dos elementos
        Grid {
            id: gridLayoutHPTA
            columns: 2
            anchors.centerIn: parent
            spacing: 10

            // Adicione 21 campos de entrada (TextField)
            Repeater {
                model: 18
                TextField {
                    placeholderText: (index % 2 === 0) ? "Dap (cm)" : (index % 2
                                                                       === 1) ? "Altura (m)" : ""
                    horizontalAlignment: Text.AlignHCenter
                    width: 120
                    height: 30
                    font.pixelSize: 14
                }
            }

            // Dialogo para seleção do local de salvamento dos arquivos de resultado
            FileDialog {
                id: saveDialogHPTA
                title: "Selecione o local para salvar o arquivo..."
                fileMode: FileDialog.SaveFile

                Connections {
                    target: saveDialogHPTA
                    onAccepted: {
                        var resultado = Julia.hpma(columnVectorsVals,
                                                   saveDialogHPTA.selectedFile)
                        bfixo = resultado[0]
                        best = resultado[1]
                        conclusionDialogHPTA.open()
                        busyIndicatorHPTA.running = false
                    }
                }
                Component.onCompleted: visible = false
            }

            // Dialogo de conclusão do processamento
            MessageDialog {
                id: conclusionDialogHPTA
                title: "Calibração Concluida com Sucesso"
                buttons: MessageDialog.Ok
                text: " Coeficientes estimados, parte aleatória \nβ0 = " + bfixo[0]
                + "\nβ1 = " + bfixo[1] + "\n\nCoeficientes calibrados \nβ0 = "
                + best[0] + "\nβ1 = " + best[1]
            }

            // Dialogo de FALTA DE DADOS 
            MessageDialog {
                id: emptyDialogHPTA
                title: "Dados insuficientes para Calibração"
                text: "Os dados informados são insuficientes para a calibração.\nPreencha todos os campos e tente novamente."
                buttons: MessageDialog.Ok
            }
        }

        BusyIndicator {
            id: busyIndicatorHPTA
            width: 120
            height: 120
            running: false
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 250
        }

        // Botão de inicialização do processamento
        Button {
            id: calibraHPTA
            text: "Calibrar Dados"
            padding: 10
            width: 250
            anchors.centerIn: gridLayoutHPTA
            anchors.verticalCenterOffset: 200
            font.bold: true
            font.pixelSize: 14
            font.family: "Arial"
            Layout.rowSpan: 9 // Estende-se por 9 linhas
            Layout.columnSpan: 2 // Estende-se por 2 colunas

            Connections {
                target: calibraHPTA
                onClicked: {
                    busyIndicatorHPTA.running = true
                    var columnVectors = []

                    // Inicializa vetores para cada coluna
                    for (var i = 0; i < gridLayoutHPTA.columns; i++) {
                        columnVectors.push([])
                    }

                    // Itera pelos filhos do GridLayout
                    for (var j = 0; j < gridLayoutHPTA.children.length; j++) {
                        // Adiciona os valores dos TextField aos vetores correspondentes
                        if (gridLayoutHPTA.children[j] instanceof TextField) {
                            var columnIndex = j % gridLayoutHPTA.columns
                            var textValue = gridLayoutHPTA.children[j].text.trim()
                            // Remove espaços em branco

                            // Verifica se o valor é vazio ou nulo
                            if (textValue === "") {
                                emptyDialogHPTA.open()
                                return
                                // Aborta o processamento se dados estiverem faltando
                            }

                            columnVectors[columnIndex].push(textValue)
                        }
                    }
                    columnVectorsVals = columnVectors
                    saveDialogHPTA.open()
                }
            }
        }
        Connections {
            target: windowHPTA
            onClosing: mainAPP.visible = true
        }
    }

    Window {
        id: windowVPCH
        title: "Calibração do Volume de Pinus caribaea hondurensis"
        width: 780
        height: 640
        x: (Screen.width - width) / 2 // Centralizar horizontalmente
        y: (Screen.height - height) / 2 // Centralizar verticalmente
        visible: false


        Rectangle {
            anchors.fill: parent

            // Defina variáveis para armazenar os dados dos campos de texto
            Image {
                id: backgroundImageVPCH
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
                id: calibrarVPCH
                text: "Calibrar"
                anchors.centerIn: parent
                padding: 10
                font.bold: true
                font.pixelSize: 16
                anchors.verticalCenterOffset: 50

                Connections {
                    target: calibrarVPCH
                    onClicked: {
                        var emptyFields = []

                        // Verifique se os campos estão vazios ou contêm apenas espaços em branco
                        if (!dap.text || dap.text.trim() === "") {
                            emptyFields.push("Dap")
                        }

                        if (!h.text || h.text.trim() === "") {
                            emptyFields.push("Altura")
                        }

                        if (!v.text || v.text.trim() === "") {
                            emptyFields.push("Volume")
                        }

                        if (emptyFields.length > 0) {
                            // Se houver campos vazios, exiba o diálogo
                            emptyDialogVPCH.text = "Ausência de dados nos campos: "
                                    + emptyFields.join(", ")
                            emptyDialogVPCH.open()
                        } else {
                            // Aqui você pode adicionar a lógica para processar os dados inseridos
                            saveDialogVPCH.open()
                        }
                    }
                }
            }
            FileDialog {
                id: saveDialogVPCH
                title: "Selecione o local para salvar o arquivo..."
                fileMode: FileDialog.SaveFile

                Connections {
                    target: saveDialogVPCH
                    onAccepted: {
                        var resultado = Julia.vpch(dap.text, h.text, v.text,
                                                   saveDialog.selectedFile)

                        bfixo = resultado[0]
                        best = resultado[1]

                        conclusionDialogVPCH.open()
                    }
                }

                Component.onCompleted: visible = false
            }
            MessageDialog {
                id: conclusionDialogVPCH
                title: "Calibração Concluida com Sucesso"
                buttons: MessageDialog.Ok
                text: " Coeficientes estimados, parte aleatória \nβ0 = " + bfixo[0]
                + "\nβ1 = " + bfixo[1] + "\n\nCoeficientes calibrados \nβ0 = "
                + best[0] + "\nβ1 = " + best[1]
            }
            MessageDialog {
                id: emptyDialogVPCH
                title: "Dados insuficientes para Calibração"
                buttons: MessageDialog.Ok
            }
        }
        Connections {
            target: windowVPCH
            onClosing: mainAPP.visible = true
        }
    }
    Window {
        id: windowVPTA
        visible: false
        width: 640
        height: 480
        x: (Screen.width - width) / 2 // Centralizar horizontalmente
        y: (Screen.height - height) / 2 // Centralizar verticalmente

        title: "Calibração da Altura do Pinus taeda"

        // Defina variáveis para armazenar os dados dos campos de texto
        Image {
            id: backgroundImageVPTA
            source: "images/wallpaper.jpg" // Substitua pelo caminho real da sua imagem
        }

        Grid {
            id: gridLayoutVPTA
            columns: 3
            anchors.centerIn: parent
            spacing: 10

            // Adicione 21 campos de entrada (TextField)
            Repeater {
                model: 21
                TextField {
                    placeholderText: (index % 3 === 0) ? "Dap (cm)" : (index % 3 === 1) ? "Altura (m)" : (index % 3 === 2) ? "Volume (m³)" : ""
                    horizontalAlignment: Text.AlignHCenter
                    width: 120
                    height: 30
                    font.pixelSize: 14
                }
            }

            FileDialog {
                id: saveDialogVPTA
                title: "Selecione o local para salvar o arquivo..."
                fileMode: FileDialog.SaveFile

                Connections {
                    target: saveDialogVPTA
                    onAccepted: {
                        var resultado = Julia.vpta(columnVectorsVals,
                                                   saveDialogVPTA.selectedFile)
                        bfixo = resultado[0]
                        best = resultado[1]
                        conclusionDialogVPTA.open()
                    }
                }
                Component.onCompleted: visible = false
            }
            MessageDialog {
                id: conclusionDialogVPTA
                title: "Calibração Concluida com Sucesso"
                buttons: MessageDialog.Ok
                text: " Coeficientes estimados, parte aleatória \nβ0 = " + bfixo[0]
                + "\nβ1 = " + bfixo[1] + "\n\nCoeficientes calibrados \nβ0 = "
                + best[0] + "\nβ1 = " + best[1]
            }
            MessageDialog {
                id: emptyDialogVPTA
                title: "Dados insuficientes para Calibração"
                text: "Os dados informados são insuficientes para a calibração.\nPreencha todos os campos e tente novamente."
                buttons: MessageDialog.Ok
            }
        }

        // Botão para processar os dados
        Button {
            id: calibraVPTA
            text: "Calibrar Dados"
            padding: 10
            width: 250
            anchors.centerIn: gridLayoutVPTA
            anchors.verticalCenterOffset: 200
            font.bold: true
            font.pixelSize: 12
            Layout.rowSpan: 7 // Estende-se por 9 linhas
            Layout.columnSpan: 3 // Estende-se por 2 colunas

            Connections {
                target: calibraVPTA
                onClicked: {
                    var columnVectors = []

                    // Inicializa vetores para cada coluna
                    for (var i = 0; i < gridLayoutVPTA.columns; i++) {
                        columnVectors.push([])
                    }

                    // Itera pelos filhos do GridLayout
                    for (var j = 0; j < gridLayoutVPTA.children.length; j++) {
                        // Adiciona os valores dos TextField aos vetores correspondentes
                        if (gridLayoutVPTA.children[j] instanceof TextField) {
                            var columnIndex = j % gridLayoutVPTA.columns
                            var textValue = gridLayoutVPTA.children[j].text.trim()
                            // Remove espaços em branco

                            // Verifica se o valor é vazio ou nulo
                            if (textValue === "") {
                                emptyDialogVPTA.open()
                                return
                                // Aborta o processamento se dados estiverem faltando
                            }

                            columnVectors[columnIndex].push(textValue)
                        }
                    }
                    columnVectorsVals = columnVectors
                    saveDialogVPTA.open()
                }
            }
        }
        Connections {
            target: windowVPTA
            onClosing: mainAPP.visible = true
        }
    }

    function updateComboBox2() {
        comboBox2.model = comboBox.currentIndex === 0 ? alturaOptions : volumeOptions
    }
}
