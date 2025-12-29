import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const ControlCenter = Widget.Window({
  name: 'controlcenter',
  visible: false,
  anchor: ['top', 'bottom', 'left', 'right'],
  layer: 'overlay',
  keymode: 'exclusive',
  child: Widget.Box({
    vertical: true,
    css: `
      padding: 40px;
      background: rgba(0, 0, 0, 0.6);
    `,
    children: [
      Widget.Label({ label: 'AGS Control Center 🚀' }),
      Widget.Label({ label: 'This means app.js was loaded correctly.' }),
    ],
  }),
});

App.config({
  style: App.configDir + '/style.css',
  windows: [ControlCenter],
});
