import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "ComboBox Example"

    ComboBox {
        id: comboBox1
        editable: true
        width: parent.width
        model: ListModel{
            id: model
            ListElement { text: "Banana"}
            ListElement { text: "Uva"}
            ListElement { text: "Pera"}
        }
        onAccepted: {
            if (find(editText) === -1)
                model.append({text: editText})
        }
    }
}
