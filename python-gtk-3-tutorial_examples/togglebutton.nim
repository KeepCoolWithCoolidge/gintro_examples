# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/button_widgets.html#togglebutton

import gintro / [gtk, gobject, gio]

proc onButtonToggled(button: ToggleButton, name: string) =
  let state = if button.active: "on" else: "off" 
  echo "Button ", name, " was turned ", state

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "ToggleButton Demo"
  window.borderWidth = 10

  let hbox = newBox(Orientation.horizontal, 6)
  window.add(hbox)

  let button1 = newToggleButtonWithLabel("Button 1")
  button1.connect("toggled", onButtonToggled, "1")
  hbox.packStart(button1, true, true, 0)

  let button2 = newToggleButtonWithLabel("Button 2")
  button2.useUnderline = true
  button2.active = true
  button2.connect("toggled", onButtonToggled, "2")
  hbox.packStart(button2, true, true, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
