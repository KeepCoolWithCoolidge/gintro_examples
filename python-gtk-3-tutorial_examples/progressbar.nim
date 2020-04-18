# Based on https://developer.gnome.org/gnome-devel-demos/stable/GtkApplicationWindow.c.html.en

import gintro / [gtk, gobject, gio, glib]

var timeoutID: uint64
var activityMode: bool

proc onShowTextToggled(check: CheckButton, progress: ProgressBar) =
  let text = if check.active: "some text" else: ""
  progress.text = text
  progress.showText = check.active

proc onActivityModeToggled(check: CheckButton, progress: ProgressBar) =
  activityMode = check.active
  if activityMode:
    progress.pulse()
  else:
    progress.fraction = 0.0

proc onRightToLeftToggled(check: CheckButton, progress: ProgressBar) =
  progress.inverted = check.active

proc onTimeout(progress: ProgressBar): bool =
  if activityMode:
    progress.pulse()
  else:
    var newValue = progress.fraction + 0.01
    if newValue > 1:
      newValue = 0
    progress.fraction = newValue
  true

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "ProgressBar Demo"
  window.borderWidth = 10

  let vbox = newBox(Orientation.vertical, 6)
  window.add(vbox)

  let progressbar = newProgressBar()
  vbox.packStart(progressbar, true, true, 0)

  let button1 = newCheckButtonWithLabel("Show text")
  button1.connect("toggled", onShowTextToggled, progressbar)
  vbox.packStart(button1, true, true, 0)

  let button2 = newCheckButtonWithLabel("Activity mode")
  button2.connect("toggled", onActivityModeToggled, progressbar)
  vbox.packStart(button2, true, true, 0)

  let button3 = newCheckButtonWithLabel("Right to Left")
  button3.connect("toggled", onRightToLeftToggled, progressbar)
  vbox.packStart(button3, true, true, 0)

  timeoutID = timeoutAdd(50, onTimeout, progressbar)
  activityMode = false

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
