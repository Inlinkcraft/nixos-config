import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const ControlCenter = Widget.Window({
  name: 'controlcenter',
  visible: false,
  anchor: ['top', 'bottom', 'left', 'right'],
  layer: 'overlay',
  keymode: 'exclusive',
  child: Widget.Box({
    css: `
      padding: 40px;
      background: rgba(0, 0, 0, 0.6);
    `,
    child: Widget.Label({
      label: 'AGS Control Center 🚀',
    }),
  }),
});

App.config({
  windows: [ControlCenter],
});
