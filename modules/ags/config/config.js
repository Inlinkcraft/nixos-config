import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';

const ControlCenter = Widget.Window({
  name: 'controlcenter',
  anchor: ['top', 'bottom', 'left', 'right'],
  layer: 'overlay',
  child: Widget.Box({
    css: 'padding: 40px;',
    child: Widget.Label({
      label: 'AGS is working 🚀',
    }),
  }),
});

App.config({
  windows: [ControlCenter],
});

