using System;
using Gtk;

/** 
 * made with http://monodevelop.com/documentation/stetic_gui_designer tutorial
 */

public partial class MainWindow: Gtk.Window {	
    public MainWindow (): base (Gtk.WindowType.Toplevel) {
        Build ();
    }

    protected void OnDeleteEvent (object sender, DeleteEventArgs a) {
        Application.Quit ();
        a.RetVal = true;
    }

    protected void OnOpen (object sender, EventArgs e) {
        int width, height;
        this.GetDefaultSize (out width, out height);
        this.Resize (width, height);
        logTextView.Buffer.Text = "";
        FileChooserDialog chooser = new FileChooserDialog (
            "Please select a logfile to view...",
            this,
            FileChooserAction.Open,
            "Cancel", ResponseType.Cancel,
            "Open", ResponseType.Accept
        );
        if (chooser.Run () == (int)ResponseType.Accept) {
            System.IO.StreamReader file = 
            System.IO.File.OpenText (chooser.Filename);

            logTextView.Buffer.Text = file.ReadToEnd ();

            //TODO to const
            this.Title = chooser.Filename.ToString () + " - " +  Consts.APP_TITLE;

            this.Resize (640, 480);
            file.Close ();
        }
        chooser.Destroy ();
    }

    protected void OnClose (object sender, EventArgs e) {
        int width, height;
        this.GetDefaultSize (out width, out height);
        this.Resize (width, height);
        logTextView.Buffer.Text = "";
        this.Title = Consts.APP_TITLE;
    }

    protected void OnExit (object sender, EventArgs e) {
        Application.Quit ();
    }

    protected void OnAbout (object sender, EventArgs e) {
        AboutDialog about = new AboutDialog ();

        about.Name = Consts.APP_TITLE;
        about.Version = Consts.APP_VERSION;
        about.Run ();
        about.Destroy ();
    }
}
