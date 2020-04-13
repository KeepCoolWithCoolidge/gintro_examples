# Based on https://developer.gnome.org/gnome-devel-demos/stable/scale.c.html.en

import gintro / [gtk, gobject, gio]
import strformat

# This is the callback function. 
# It is a handler function which reacts to the signal. 
# In this case, it will notify the user the value of their scale as a label.
proc hscaleMoved(scale: Scale, label: Label) =
  # Get the value of the range, and convert it into a string which will be
  # used as a new label for the horizontal scale.
  # .0f - stands for a double that will have 0 decimal places.
  let pos = scale.value
  label.text = &"Horizontal scale is {pos:.0f}"

# This is the second callback function. It is a handler function which 
# reacts to the signal. It does the same thing as the function above, except with
# the vertical scale.
proc vscaleMoved(scale: Scale, label: Label) =
  let pos = scale.value
  # .1f - stands for a double that will have 1 decimal place
  label.text = &"Vertical scale is {pos:.1f}"

proc appActivate(app: Application) =
  # Create a window with a title and a default size
  let window = newApplicationWindow(app)
  window.title = "Scale Example"
  window.defaultSize = (400, 300)
  window.borderWidth = 5

  # Two labels to be shown in the window
  let hlabel = newLabel("Move the scale handle...")
  let vlabel = newLabel("Move the scale handle...")

  # The Adjustment object represents a value 
  # which has an associated lower and upper bound.
  let hadjustment = newAdjustment(0, 0, 100, 5, 10, 0)
  let vadjustment = newAdjustment(50, 0, 100, 5, 10, 0)

  # Create the Horizontal scale, making sure the 
  # digits used have no decimals.
  let hscale = newScale(Orientation.horizontal, hadjustment)
  hscale.digits = 0

  # Allow it to expand horizontally (if there's space), and 
  # set the vertical alignment
  hscale.hexpand = true
  hscale.valign = Align.start

  # Connecting the "value-changed" signal for the horizontal scale 
  # to the appropriate callback function. 
  hscale.connect("value-changed", hscaleMoved, hlabel)

  # Create the Vertical scale. This time, we will see what happens 
  # when the digits aren't initially set.
  let vscale = newScale(Orientation.vertical, vadjustment)
  vscale.vexpand = true

  # Connecting the "value-changed" signal for the vertical scale to 
  # the appropriate callback function.
  vscale.connect("value-changed", vscaleMoved, vlabel)

  # Create a grid and arrange everything accordingly
  let grid = newGrid()
  grid.columnSpacing = 10
  grid.columnHomogeneous = true
  grid.attach(hscale, 0, 0, 1, 1)
  grid.attach(vscale, 1, 0, 1, 1)
  grid.attach(hlabel, 0, 1, 1, 1)
  grid.attach(vlabel, 1, 1, 1, 1)

  window.add(grid)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
