import { App, Astal } from "astal";
import { Window, Box, Label } from "astal/gtk3";

const controlcenter = new Window({
  name: "controlcenter",
  anchor: Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT,
  margins: { top: 20, right: 20 },
  layer: Astal.Layer.OVERLAY,
  visible: false,

  child: new Box({
    vertical: true,
    css: `
      background: #1e1e2e;
      padding: 20px;
      border-radius: 12px;
      min-width: 300px;
    `,
    children: [
      new Label({ label: "AGS Control Center (v2)" }),
    ],
  }),
});

App.start({
  windows: [controlcenter],
});
