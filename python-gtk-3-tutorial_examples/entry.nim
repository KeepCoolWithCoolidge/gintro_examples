# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/entry.html#example

import gintro / [gtk, gobject, gio, glib]

var timeoutID: uint64

proc onEditableToggled(button: CheckButton, entry: Entry) =
  entry.editable = button.active

proc onVisibleToggled(button: CheckButton, entry: Entry) =
  entry.visibility = button.active

proc onIconToggled(button: CheckButton, entry: Entry) =
  var iconName: string
  if button.active:
    iconName = "system-search-symbolic"
  else:
    iconName = ""
  entry.setIconFromIconName(EntryIconPosition.primary, iconName)

proc doPulse(entry: Entry): bool =
  entry.progressPulse()
  true

proc onPulseToggled(button: CheckButton, entry: Entry) =
  if button.active:
    entry.progressPulseStep = 0.2
    timeoutID = timeoutAdd(100, doPulse, entry)
  else:
    discard remove(timeoutID.int)
    entry.progressPulseStep = 0.0

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Entry Demo"
  window.setSizeRequest(200, 100)

  let vbox = newBox(Orientation.vertical, 6)
  window.add(vbox)

  let entry = newEntry()
  entry.text = "Hello World"
  vbox.packStart(entry, true, true, 0)

  let hbox = newBox(Orientation.horizontal, 6)
  vbox.packStart(hbox, true, true, 0)

  let checkEditable = newCheckButtonWithLabel("Editable")
  checkEditable.connect("toggled", onEditableToggled, entry)
  checkEditable.active = true
  hbox.packStart(checkEditable, true, true, 0)

  let checkVisible = newCheckButtonWithLabel("Visible")
  checkVisible.connect("toggled", onVisibleToggled, entry)
  checkVisible.active = true
  hbox.packStart(checkVisible, true, true, 0)

  let pulse = newCheckButtonWithLabel("Pulse")
  pulse.connect("toggled", onPulseToggled, entry)
  pulse.active = false
  hbox.packStart(pulse, true, true, 0)

  let icon = newCheckButtonWithLabel("Icon")
  icon.connect("toggled", onIconToggled, entry)
  icon.active = false
  hbox.packStart(icon, true, true, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
