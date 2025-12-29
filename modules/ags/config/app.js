const { Gtk } = imports.gi;
const Astal = imports.gi.Astal;

App.start({
  windows: [
    new Astal.Window({
      name: "controlcenter",
      anchor: Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT,
      layer: Astal.Layer.OVERLAY,
      visible: false,

      child: new Gtk.Box({
        orientation: Gtk.Orientation.VERTICAL,
        spacing: 12,
        css: `
          background: rgba(30, 30, 46, 0.9);
          padding: 20px;
          border-radius: 14px;
          min-width: 320px;
        `,
        children: [
          new Gtk.Label({ label: "AGS Control Center (GTK4)" }),
          new Gtk.Label({ label: "If you see this, app.js is deployed correctly." }),
        ],
      }),
    }),
  ],
});
