# Based on https://developer.gnome.org/gnome-devel-demos/stable/button.c.html.en

import gintro / [gtk, gobject, gio, glib]

# This is the callback function. It is a handler function which
# reacts to the signal. In this case, it will cause the button label's
# string to reverse.
proc buttonClicked(button: Button) =
  let oldLabel = button.label
  let newLabel = oldLabel.utf8Strreverse(-1)
  button.label = newLabel

proc appActivate(app: Application) =
  # Create a window with a title and a default size
  let window = newApplicationWindow(app)
  window.title = "Nim Button"
  window.defaultSize = (250, 50)

  # Create a button with a label, and add it to the window
  let button = newButton("Click Me")
  window.add(button)

  # Connecting the clicked signal to the callback function
  button.connect("clicked", buttonClicked)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()

