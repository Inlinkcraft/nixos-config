imports.gi.versions.Gtk = "4.0";
imports.gi.versions.Gdk = "4.0";
imports.gi.versions.Astal = "1.0"; // if this errors later, we’ll switch it

const Gtk = imports.gi.Gtk;
const Astal = imports.gi.Astal;

Gtk.init();

const controlcenter = new Astal.Window({
  name: "controlcenter",
  anchor: Astal.WindowAnchor.TOP | Astal.WindowAnchor.RIGHT,
  layer: Astal.Layer.OVERLAY,
  visible: false,

  child: new Gtk.Box({
    orientation: Gtk.Orientation.VERTICAL,
    spacing: 12,
    css_classes: ["cc-root"],
    children: [
      new Gtk.Label({ label: "AGS Control Center (GTK4)", css_classes: ["cc-title"] }),
      new Gtk.Label({ label: "GTK4 typelib found ✅", css_classes: ["cc-sub"] }),
    ],
  }),
});

App.start({
  css: `${App.configDir}/style.css`,
  windows: [controlcenter],
});
