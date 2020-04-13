# Based on https://developer.gnome.org/gnome-devel-demos/stable/spinbutton.c.html.en

import gintro / [gtk, gobject, gio]
import strformat

# This is the callback function. 
# It is a handler function which reacts to the signal. 
# In this case, it will notify the user the value of their spinbutton 
# as a label.
proc spinClicked(spinButton: SpinButton, label: Label) =
  let value = spinButton.valueAsInt
  label.text = &"The number you selected is {value}"

proc appActivate(app: Application) =
  # Create a window with a title, a border width, and a default size
  let window = newApplicationWindow(app)
  window.title = "SpinButton Example"
  window.defaultSize = (210, 70)
  window.borderWidth = 5

  # Create a label to be shown in the window
  let label = newLabel("Choose a number")

  # Create an adjustment representing an adjustable bounded value
  let adjustment = newAdjustment(0, 0, 100, 1, 0, 0)

  # Create a spin button that is to be as wide as possible
  let spinButton = newSpinButton(adjustment, 1, 0)
  spinButton.hexpand = true

  # Connecting the "value-changed" signal for the spinbutton 
  # to the appropriate callback function. 
  spinButton.connect("value-changed", spinClicked, label)

  # Create a grid and arrange everything accordingly
  let grid = newGrid()
  grid.columnSpacing = 10
  grid.columnHomogeneous = true
  grid.attach(spinButton, 0, 0, 1, 1)
  grid.attach(label, 0, 1, 1, 1)

  window.add(grid)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
