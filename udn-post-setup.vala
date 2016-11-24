using Gtk;
int main (string[] args) {
    Gtk.init (ref args);

    var window = new Window ();
    window.title = "Unidockynapse Control Center";
    window.border_width = 10;
    window.window_position = WindowPosition.CENTER;
    window.set_default_size (350,140);
    window.destroy.connect (Gtk.main_quit);

    var button = new Button.with_label ("Change language");
    button.clicked.connect (change_language);
    
    var button1 = new Button.with_label ("Clear recent documents");
    button1.clicked.connect (clear_history);

    var button2 = new Button.with_label ("Reset Gnome Keyring passwords");
    button2.clicked.connect (reset_gnome_keyring_password);

    var button3 = new Button.with_label ("Install LAMP Server (Apache + Mysql + PHP)");
    button3.clicked.connect (install_lamp);

    var button4 = new Button.with_label ("Change Keyboard Layout");
    button4.clicked.connect (change_keyboard_layout); 

     var box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
  box.set_border_width(2);

    box.add (button);

    box.add (button1);
    box.add (button2);
    box.add (button3);
    box.add (button4);
    window.add (box);
    window.show_all ();

    Gtk.main ();
    return 0;

}
 public void change_language () 
  {   
    try {
      Process.spawn_command_line_sync (@"gnome-language-selector");
      messagebox_show ("Success", "Your language has been changed");
    }
    catch (Error e){
      string msg = e.message;
      stderr.printf(msg);
      messagebox_show ("Error", msg);
    }
  }
   public void messagebox_show(string title, string message)
  {
    var dialog = new Gtk.MessageDialog(
   null,
   Gtk.DialogFlags.MODAL, 
   Gtk.MessageType.INFO, 
   Gtk.ButtonsType.OK, 
   message);
   
    dialog.set_title(title);
    dialog.run();
    dialog.destroy();
  }

   public void clear_history () 
  {
    string HOME = Environment.get_home_dir ();

    try {
      Process.spawn_command_line_sync (@"rm $HOME/.local/share/recently-used.xbel");
      Process.spawn_command_line_sync (@"touch $HOME/.local/share/recently-used.xbel");
      messagebox_show ("Success", "Your recent documents history has been cleared");
    }
    catch (Error e){
      string msg = e.message;
      stderr.printf(msg);
      messagebox_show ("Error", msg);
    }
  }
   public void reset_gnome_keyring_password () 
  {
    string HOME = Environment.get_home_dir ();

    try {
      Process.spawn_command_line_sync (@"rm ~/.local/share/keyrings/login.keyring");
      messagebox_show ("Success", "Your gnome keyring password was reset, now you can create another");
    }
    catch (Error e){
      string msg = e.message;
      stderr.printf(msg);
      messagebox_show ("Error", msg);
    }
  }

   public void install_lamp () 
  {
    try {
      Process.spawn_command_line_sync ("pkexec tasksel");
      messagebox_show ("Success", "Your LAMP installation was succeful installed");
    }
    catch (Error e){
      string msg = e.message;
      stderr.printf(msg);
      messagebox_show ("Error", msg);
    }
  }
   public void change_keyboard_layout () 
  {
    try {
      Process.spawn_command_line_sync ("pkexec dpkg-reconfigure keyboard-configuration");
      messagebox_show ("Success", "Your Keyboard is now configured");
    }
    catch (Error e){
      string msg = e.message;
      stderr.printf(msg);
      messagebox_show ("Error", msg);
    }
  }