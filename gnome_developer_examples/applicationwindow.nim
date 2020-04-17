# Based on https://developer.gnome.org/gnome-devel-demos/stable/spinner.c.html.en

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Hello Nim"
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
