namespace Emulsion {
    public class PaletteInfo : Object {
        /*
         * palname : string of the Palette's name e.g. "GNOME";
         * colors : string array of the Palette, all in hexcodes;
         * colorsnames : string array of the Palette, for color names;
         */

        public string palname { get; set; }
        public Gee.TreeSet<string> colors { get; set; }
        public Gee.TreeSet<string> colorsnames { get; set; }
    }

    public class PaletteRenderer : Gtk.Box {
        public PaletteInfo _palette;
        public PaletteInfo palette {
            get {
                return _palette;
            }

            set {
                if(_palette == value) {
                    return;
                }
                _palette = value;
                queue_draw ();
            }
        }

        construct {
            this.get_style_context().add_class ("palette");
            this.set_overflow(Gtk.Overflow.HIDDEN);
            this.set_orientation (Gtk.Orientation.HORIZONTAL);
            this.set_halign (Gtk.Align.CENTER);
            this.set_margin_start (6);
            this.set_margin_top (6);
            this.set_margin_end (6);
            this.set_size_request (256, 64);
	    }

	    protected override void snapshot (Gtk.Snapshot snapshot) {
	        int j = 0;
	        var arrco = palette.colors.to_array ();
            for (int i = 0; i < arrco.length; i++) {
                Gdk.RGBA gc = {};
                gc.parse (arrco[i]);

                switch (arrco.length) {
                    case 1:
                        snapshot.append_color (gc, {{i * 256, 0}, {256, 64}});
                        break;
                    case 2:
                        snapshot.append_color (gc, {{i * 128, 0}, {128, 64}});
                        break;
                    case 3:
                        snapshot.append_color (gc, {{i * 85, 0}, {85, 64}});
                        break;
                    case 4:
                        snapshot.append_color (gc, {{i * 64, 0}, {64, 64}});
                        break;
                    case 5:
                        snapshot.append_color (gc, {{i * 51, 0}, {51, 64}});
                        break;
                    case 6:
                        snapshot.append_color (gc, {{i * 43, 0}, {43, 64}});
                        break;
                    case 7:
                        snapshot.append_color (gc, {{i * 37, 0}, {37, 64}});
                        break;
                    case 8:
                        snapshot.append_color (gc, {{i * 32, 0}, {32, 64}});
                        break;
                    default:
                        if (i < 8) {
                            snapshot.append_color (gc, {{i * 32, 0}, {32, 32}});
                            this.set_size_request (i * 32, 32);
                        } else {
                            if (i <= 15) {
                                snapshot.append_color (gc, {{j++ * 32, 32}, {32, 32}});
                            } else if (i > 15) {
                                if (Utils.contrast_ratio(gc, {0,0,0,1}) > Utils.contrast_ratio(gc, {1,1,1,1}) + 3) {
                                    snapshot.append_color ({0,0,0,1}, {{232, 48}, {16, 2}});
                                    snapshot.append_color ({0,0,0,1}, {{239, 41}, {2, 16}});
                                } else {
                                    snapshot.append_color ({1,1,1,1}, {{232, 48}, {16, 2}});
                                    snapshot.append_color ({1,1,1,1}, {{239, 41}, {2, 16}});
                                }
                            }
                            this.set_size_request (8 * 32, 64);
                        }
                        break;
                }
            }
        }
    }
}
