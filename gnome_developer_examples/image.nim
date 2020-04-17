# Based on https://developer.gnome.org/gnome-devel-demos/stable/image.c.html.en

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  let image = newImageFromFile("Nim-logo.png")
  window.title = "Welcome to Nim"
  window.defaultSize = (300, 300)

  window.add(image)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
