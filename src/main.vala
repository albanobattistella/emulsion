/* main.vala
 *
 * Copyright 2021 Lains
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
* Copyright (c) 2017-2021 Lains
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/
namespace Emulsion {
    public class Application : Gtk.Application {
        public static MainWindow win = null;
        public static GLib.Settings gsettings;
        private const GLib.ActionEntry app_entries[] = {
            { "quit", on_quit },
        };

        public Application () {
            Object (
                flags: ApplicationFlags.FLAGS_NONE,
                application_id: Config.APP_ID
            );
            add_action_entries(app_entries, this);
        }
        static construct {
            gsettings = new GLib.Settings ("io.github.lainsce.Emulsion");
        }

        construct {
            Intl.setlocale (LocaleCategory.ALL, "");
            Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.GNOMELOCALEDIR);
            Intl.textdomain (Config.GETTEXT_PACKAGE);
        }
        private void on_quit() {
            win.destroy();
        }
        public MainWindow get_window () {
            return win;
        }
        protected override void activate () {
            if (win != null) {
                win.present ();
                return;
            }
            win = new MainWindow (this);
        }
        public static int main (string[] args) {
            var app = new Emulsion.Application ();
            return app.run (args);
        }
    }
}
