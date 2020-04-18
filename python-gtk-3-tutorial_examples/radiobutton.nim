# Based on https://developer.gnome.org/gnome-devel-demos/stable/GtkApplicationWindow.c.html.en

import gintro / [gtk, gobject, gio]

proc onButtonToggled(button: RadioButton, name: string) =
  let state = if button.active: "on" else: "off"
  echo "Button ", name, " was turned ", state

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "RadioButton Demo"
  window.borderWidth = 10

  let hbox = newBox(Orientation.horizontal, 6)
  window.add(hbox)

  let button1 = newRadioButtonWithLabelFromWidget(nil, "Button 1")
  button1.connect("toggled", onButtonToggled, "1")
  hbox.packStart(button1, false, false, 0)

  let button2 = newRadioButtonFromWidget(button1)
  button2.label = "Button 2"
  button2.connect("toggled", onButtonToggled, "2")
  hbox.packStart(button2, false, false, 0)

  let button3 = newRadioButtonWithMnemonicFromWidget(button1, "Button 3")
  button3.connect("toggled", onButtonToggled, "3")
  hbox.packStart(button3, false, false, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
