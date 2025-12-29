import { App } from "resource:///com/github/Aylur/ags/astal.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

const ControlCenter = Widget.Window({
  name: "controlcenter",
  anchor: ["top", "right"],
  margins: [20, 20, 20, 20],
  layer: "overlay",
  visible: false,

  child: Widget.Box({
    vertical: true,
    css: `
      padding: 20px;
      background: #1e1e2e;
      border-radius: 12px;
      min-width: 300px;
    `,
    children: [
      Widget.Label({ label: "AGS v2 Control Center" }),
    ],
  }),
});

App.start({
  windows: [ControlCenter],
});
