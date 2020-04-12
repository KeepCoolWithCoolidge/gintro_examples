import gintro / [gtk, gobject, gio]

# This is the callback function. It is a handler function
# which reacts to the signal. In this case, it will cause the
# spinner to start and stop according to how many times the user
# presses the button.
proc buttonToggledCb(button: ToggleButton, userData: Spinner) =
  if button.getActive():
    userData.start()
  else:
    userData.stop()

proc appActivate(app: Application) =

  # Create a window with a title, border width and a default size
  let window = newApplicationWindow(app)
  window.title = "ToggleButton Example"
  window.defaultSize = (300, 300)
  window.borderWidth = 30

  # Create a togglebutton with a label
  let button = newToggleButtonWithLabel("Start/Stop")
  let spinner = newSpinner()
  spinner.hexpand = true
  spinner.vexpand = true

  # Create a grid and set the row spacing, attach the togglebutton
  let grid = newGrid()
  grid.rowHomogeneous = false
  grid.rowSpacing = 15
  grid.attach(spinner, 0, 0, 1, 1)
  grid.attach(button, 0, 1, 1, 1)

  window.add(grid)

  # Connecting the toggled signal to the callback
  button.connect("toggled", buttonToggledCb, spinner)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard run(app)

main()
