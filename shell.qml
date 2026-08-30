import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

PanelWindow {
  id: bar

  anchors {
      top: true;
      left: true;
      right: true;
  }
  margins {
    top: 13
    left: 5
    right: 5
  }
  implicitHeight: 33
  color: "transparent"

  Poller {
    id: clock
    command: "date +%H:%M"
    interval: 6000
  }

  Poller {
    id: vol
    command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf\"%d\", $2*100}'"
    interval: 1000
  }

  Poller {
    id: bat
    command: "cat /sys/class/power_supply/BAT0/capacity"
    interval: 30000
  }

  Poller {
    id: bt
    command: "bluetoothctl show | grep -q 'Powered: yes' && echo on || echo off"
    interval: 5000
  }

  Poller {
    id: net
    command: "nmcli -t -f NAME connection show --active | head -n1"
  }

  readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[0] ?? null

  RowLayout {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 14
    spacing: 8

    Workspaces {}

    Pill {
      icon: "music_note"
      maxLabelWidth: 200
      label: bar.player ? `${bar.player.trackArtist || "Unknown"} - ${bar.player.trackTitle || ""}` : "Nothing playing"
    }
  }

  RowLayout {
    id: centerGroup
    anchors.centerIn: parent
    spacing: 8

    Pill {
      icon: "nest_clock_farsight_analog";
      label: clock.value
    }

    // Workspaces {}
  }

  RowLayout {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 14
    spacing: 8

    Pill {
      icon: "volume_up";
      // label: vol.value + "%"  // Won't work in VM
      label: 70 + "%" // Temporary hardcoded
      iconColor: "#3dd1b0"
    }
    Pill {
      icon: "battery_android_full";
      // label: bat.value + "%"  // Won't work in VM
      label: 89 + "%"  // Temporary hardcoded
      iconColor: "#7ad9a8"
    }
    Pill {
      icon: "bluetooth";
      label: bt.value
      iconColor: "#f5cd5b"
    }
    Pill {
      icon: "android_wifi_3_bar";
      label: net.value
      iconColor: "#ff6048"
    }
  }
}