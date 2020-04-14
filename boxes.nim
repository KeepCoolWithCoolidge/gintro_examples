# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html#boxes

import gintro / [gtk, gobject, gio]

proc onButton1Clicked(button: Button) =
  echo "Hello"

proc onButton2Clicked(button: Button) =
  echo "Goodbye"

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Hello World"

  let box = newBox(Orientation.horizontal, 6)
  window.add(box)

  let button1 = newButton()
  button1.label = "Hello"
  button1.connect("clicked", onButton1Clicked)
  box.packStart(button1, true, true, 0)

  let button2 = newButton()
  button2.label = "Goodbye"
  button2.connect("clicked", onButton2Clicked)
  box.packStart(button2, true, true, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
