# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/spinner.html#example
import gintro / [gtk, gobject, gio]

proc onButtonToggled(button: ToggleButton, spinner: Spinner) =
  if button.active:
    spinner.start()
    button.label = "Stop Spinning"
  else:
    spinner.stop()
    button.label = "Start Spinning"

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Spinner"
  window.borderWidth = 3

  let spinner = newSpinner()

  let button = newToggleButton()
  button.label = "Start Spinning"
  button.connect("toggled", onButtonToggled, spinner)
  button.active = true

  let table = newTable(3, 2, true)
  table.attachDefaults(button, 0, 2, 0 ,1)
  table.attachDefaults(spinner, 0, 2, 2, 3)

  window.add(table)
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
