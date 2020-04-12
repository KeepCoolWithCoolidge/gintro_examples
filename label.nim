# Based on https://developer.gnome.org/gnome-devel-demos/stable/label.c.html.en

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  # Create a window with a title and a default size
  let window = newApplicationWindow(app)
  window.title = "Welcome to Nim"
  window.defaultSize = (200, 100)

  # Create a label and set its alignment. Setting the line wrap to TRUE makes
  # the label break lines if the text exceeds the widget's size. When set to
  # FALSE the text gets cut off by the edge of the widget
  let label = newLabel("Hello Nim!")
  label.setJustify(Justification.center)
  label.setLineWrap(true)

  window.add(label)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
