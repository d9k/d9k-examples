using System;
using Gtk;

namespace stetic_gui_designer_tutorial {
    class MainClass {
        public static void Main (string[] args) {
            Application.Init ();
            MainWindow win = new MainWindow ();
            win.Show ();
            Application.Run ();
        }
    }
}
