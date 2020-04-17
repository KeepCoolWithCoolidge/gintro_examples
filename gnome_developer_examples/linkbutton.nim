# Based on https://developer.gnome.org/gnome-devel-demos/stable/linkbutton.c.html.en

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "LinkButton"
  window.defaultSize = (250, 50)

  let linkbutton = newLinkButton("https://nim-lang.org")
  linkbutton.label = "Link to Nim website"

  window.add(linkbutton)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
