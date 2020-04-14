# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html#notebook

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Simple Notebook Example"
  window.borderWidth = 3

  let notebook = newNotebook()
  window.add(notebook)

  let page1 = newBox(Orientation.horizontal, 0)
  page1.borderWidth = 10
  page1.add(newLabel("Default Page!"))
  discard notebook.appendPage(page1, newLabel("Plain Label"))

  let page2 = newBox(Orientation.horizontal, 0)
  page2.borderWidth = 10
  page2.add(newLabel("A page with an image for a Title."))
  discard notebook.appendPage(page2, newImageFromIconName("help-about", IconSize.menu.int))

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
