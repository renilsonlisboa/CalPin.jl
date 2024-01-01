import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.julialang

ApplicationWindow {
  title: "My Application"
  width: 800
  height: 600
  visible: true

  ColumnLayout {
    id: root
    spacing: 6
    anchors.fill: parent

        function do_plot()
        {
        if(jdisp === null)
            return;

        Julia.plot_result(jdisp, def_graph);
        }

        function init_and_plot()
        {
        if(jdisp === null)
            return;

        Julia.init_backend(jdisp.width, jdisp.height);
        do_plot();
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