import App from "resource:///com/github/Aylur/ags/app.js";
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
      background: rgba(30, 30, 46, 0.92);
      padding: 20px;
      border-radius: 14px;
      min-width: 340px;
    `,
    children: [
      Widget.Label({
        label: "AGS Control Center (GTK3)",
      }),
      Widget.Label({
        label: "This is the correct setup for NixOS today.",
      }),
    ],
  }),
});

App.config({
  windows: [ControlCenter],
});
