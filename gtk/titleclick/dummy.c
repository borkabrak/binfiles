#include <gtk/gtk.h>

/* 
  Sample from:

    https://developer.gnome.org/gtk3/3.12/gtk-getting-started.html#id-1.2.3.3

  Compile with:

    gcc `pkg-config --cflags gtk+-3.0` -o <name> <thisfile>.c `pkg-config --libs gtk+-3.0`
*/

int
main (int   argc,
      char *argv[])
{
  GtkWidget *window;

  gtk_init (&argc, &argv);

  window = gtk_window_new (GTK_WINDOW_TOPLEVEL);

  //gtk_window_set_title (GTK_WINDOW (window), "Window");

  g_signal_connect (window, "click", G_CALLBACK ( gtk_window_set_title (GTK_WINDOW (window), argv[1])), NULL);

  gtk_widget_show (window);

  gtk_main ();

  return 0;
}
