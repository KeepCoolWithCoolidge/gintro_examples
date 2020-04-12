# Based on https://developer.gnome.org/gnome-devel-demos/stable/radiobutton.c.html.en

import gintro / [gtk, gobject, gio]

# Signal handler for the "toggled" signal of the RadioButton
proc buttonToggledCb(button: RadioButton) =
  var bState = if button.active: "on" else: "off"
  var buttonLabel = button.label
  echo buttonLabel, " was turned ", bState

proc appActivate(app: Application) =
  # Create a window with a set title and default size.
  # Also, set a border width for the amount of space to leave
  # inside the window
  let window = newApplicationWindow(app)
  window.title = "RadioButton Example"
  window.defaultSize = (250, 100)
  window.borderWidth = 20

  # Create an initial radio button
  let button1 = newRadioButtonWithLabel(nil, "Button 1")

  # Create a second radio button, and add it to the same group as Button 1
  let button2 = newRadioButtonWithLabelFromWidget(button1, "Button 2")

  # Create a third button, and add it to the same group as Button 1
  let button3 = newRadioButtonWithLabelFromWidget(button1, "Button 3")

  # Create a grid, attach the buttons, and position them accordingly
  let grid = newGrid()
  grid.attach(button1, 0, 0, 1, 1)
  grid.attach(button2, 0, 1, 1, 1)
  grid.attach(button3, 0, 2, 1, 1)

  # Be sure to set the initial state of each button
  button2.active = true
  button1.active = false
  button3.active = false

  # Connect the signal handlers (aka Callback functions) to the buttons
  button1.connect("toggled", buttonToggledCb)
  button2.connect("toggled", buttonToggledCb)
  button3.connect("toggled", buttonToggledCb)

  window.add(grid)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()
