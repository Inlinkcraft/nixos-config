// IMPORTANT: pick GI versions BEFORE importing anything.
// This prevents the "Gdk 4.0 but 3.0 already loaded" crash.
imports.gi.versions.Gtk = "4.0";
imports.gi.versions.Gdk = "4.0";

/*
Astal was reported as "2 versions available" on your system.
You MUST pin one version here to avoid ambiguity.

If "1.0" doesn't exist on your machine, change it to the other one
(e.g. "0.1" or "2.0") and re-run.

Quick test (run manually):
  gjs -c 'imports.gi.versions.Astal="1.0"; imports.gi.Astal; print("ok")'
  gjs -c 'imports.gi.versions.Astal="0.1"; imports.gi.Astal; print("ok")'
*/
imports.gi.versions.Astal = "1.0";

const Gtk = imports.gi.Gtk;
const Astal = imports.gi.Astal;

// Ensure GTK is initialized (safe under Gtk4LayerShell preload too)
Gtk.init();

// One window, toggled by:  ags toggle controlcenter
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
      new Gtk.Label({ label: "If you see this, GTK4 + Astal is working.", css_classes: ["cc-sub"] }),
    ],
  }),
});

App.start({
  css: `${App.configDir}/style.css`,
  windows: [controlcenter],
});
