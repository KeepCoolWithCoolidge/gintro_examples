# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/button_widgets.html#linkbutton

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "LinkButton Demo"
  window.borderWidth = 10

  let button = newLinkButtonWithLabel("http://www.gtk.org", "Visit GTK+ Homepage")
  window.add(button)
  
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
