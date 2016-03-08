


void main (string[] args) {
  Gtk.init (ref args);
  var window = new Gtk.Window ();
  var image_view = new Gtk.ImageView ();
  var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
  var box2 = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 6);
  var entry = new Gtk.Entry ();
  entry.text = "http://www.gtk.org/images/header-logo.png";
  var button = new Gtk.Button.with_label ("show");

  var sess = new Soup.Session ();

  image_view.fit_allocation = true;
  image_view.transitions_enabled = true;
  image_view.vexpand = true;

  button.clicked.connect (() => {
    var uri = entry.text;
    message ("uri: %s", uri);

    var msg = new Soup.Message ("GET", uri);
    sess.send_async.begin (msg, null, (obj, res) => {
        var inputstream = sess.send_async.end (res);
        image_view.load_from_stream_async.begin (inputstream, 0);
    });
  });

  box2.pack_start (entry, true, true);
  box2.pack_end (button, false, false);
  box.add (box2);
  box.add (image_view);

  window.add (box);

  window.show_all ();
  Gtk.main ();
}
