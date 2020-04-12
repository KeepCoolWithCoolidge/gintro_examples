# Based on https://developer.gnome.org/gnome-devel-demos/stable/checkbutton.c.html.en

import gintro / [gtk, gobject, gio]

proc toggledCb(button: CheckButton, userData: ApplicationWindow) =
  if button.active:
    userData.title = "CheckButton Example"
  else:
    userData.title = ""

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "CheckButton Example"
  window.defaultSize = (300, 100)

  let checkbutton = newCheckButtonWithLabel("Show Title")
  checkbutton.active = true
  checkbutton.connect("toggled", toggledCb, window)
  window.add(checkbutton)
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()
