import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
  implicitWidth: row.implicitWidth + 22
  implicitHeight: 33
  radius: height / 2
  color: "#040e0d"

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 8

    Repeater {
      model: Hyprland.workspaces

      Rectangle {
        implicitWidth: modelData.active ? 18 : 6
        implicitHeight: implicitWidth
        radius: width / 4  // This will make the radius little rounded
        color: modelData.active ? "transparent" : "#1d3631"
        border.width: modelData.active ? 2 : 0
        border.color: "#3dd1b0"

        Text {
          text: modelData.name
          color: modelData.active ? "#3dd1b0": "#040e0d"
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
          anchors.fill: parent
        }

        Behavior on implicitWidth {
          NumberAnimation {
            duration: 160;
            easing.type: Easing.OutCubic
          }
        }
      }
    }
  }
}