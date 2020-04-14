# Based on https://developer.gnome.org/gnome-devel-demos/stable/combobox.c.html.en

import gintro / [gtk, gobject, gio]

# This is the callback function. It is a handler function which reacts to the
# signal. In this case, if the row selected is not the first one of the
# ComboBox, we write its value in the terminal for the user.
proc onChanged(comboBoxText: ComboBoxText) =
  if comboBoxText.active != 0:
    var distro = comboBoxText.activeText
    echo "You chose ", distro

proc appActivate(app: Application) =
  # Create a window with a title, border width, and a default size. Setting the
  # size to -1 means to use the "natural" default size.
  # (the size request of the window)
  let window = newApplicationWindow(app)
  window.title = "Welcome to Nim"
  window.defaultSize = (200, -1)
  window.borderWidth = 10

  # Create the combo box and append your string values to it.
  let comboBox = newComboBoxText()
  let distros = ["Select distribution", "Fedora", "Mint", "Suse"]

  for element in distros:
    comboBox.appendText(element)

  # Choose to set the first row as the active one by default, from the beginning
  comboBox.active = 0

  # Connect the signal emitted when a row is selected to the appropriate
  # callback function.
  comboBox.connect("changed", onChanged)

  # Add it to the window
  window.add(comboBox)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
