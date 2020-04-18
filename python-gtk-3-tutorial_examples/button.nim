# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/button_widgets.html#button

import gintro / [gtk, gobject, gio]

proc onClickMeClicked(button: Button) =
  echo "\"Click me\" button was clicked"

proc onOpenClicked(button: Button) =
  echo "\"Open\" button was clicked"

proc onCloseClicked(button: Button, appWin: ApplicationWindow) =
  echo "Closing application"
  appWin.getApplication().quit()

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Button Demo"
  window.borderWidth = 10

  let hbox = newBox(Orientation.horizontal, 6)
  window.add(hbox)

  let button1 = newButton("Click Me")
  button1.connect("clicked", onClickMeClicked)
  hbox.packStart(button1, true, true, 0)

  let button2 = newButtonWithMnemonic("_Open")
  button2.connect("clicked", onOpenClicked)
  hbox.packStart(button2, true, true, 0)

  let button3 = newButtonWithMnemonic("_Close")
  button3.connect("clicked", onCloseClicked, window)
  hbox.packStart(button3, true, true, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
