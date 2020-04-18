# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/button_widgets.html#linkbutton

import gintro / [gtk, gobject, gio]

proc onNumericToggled(check: CheckButton, spin: SpinButton) =
  spin.numeric = check.active

proc onIfValidToggled(check: CheckButton, spin: SpinButton) =
  let policy = if check.active: SpinButtonUpdatePolicy.if_valid 
    else: SpinButtonUpdatePolicy.always
  spin.updatePolicy = policy

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "SpinButton Demo"
  window.borderWidth = 10

  let hbox = newBox(Orientation.horizontal, 6)
  window.add(hbox)

  let adjustment = newAdjustment(0, 0, 100, 1, 10, 0)
  let spinbutton = newSpinButton(adjustment, 0, 0)
  hbox.packStart(spinbutton, false, false, 0)

  let checkNumeric = newCheckButton()
  checkNumeric.label = "Numeric"
  checkNumeric.connect("toggled", onNumericToggled, spinbutton)
  hbox.packStart(checkNumeric, false, false, 0)

  let checkIfValid = newCheckButton()
  checkIfValid.label = "If Valid"
  checkIfValid.connect("toggled", onIfValidToggled, spinbutton)
  hbox.packStart(checkIfValid, false, false, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
