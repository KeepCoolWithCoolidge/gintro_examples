# Based on https://developer.gnome.org/gnome-devel-demos/stable/entry.c.html.en

import gintro / [gtk, gobject, gio]

proc onActivate(entry: Entry) =
  var name = entry.text
  echo "Hello, ", name, "!" 

proc appActivate(app: Application) =
  # Create a window with a title, a default size,
  # and a set border width
  let window = newApplicationWindow(app)
  window.title = "What is your name?"
  window.defaultSize = (300, 100)
  window.borderWidth = 10

  # Create a new entry box, and add it to the window
  let entryBox = newEntry()
  window.add(entryBox)

  # Connecting the activate signal to the callback
  entryBox.connect("activate", onActivate)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
