# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/label.html#example

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Label Example"

  let hbox = newBox(Orientation.horizontal, 10)
  hbox.homogeneous = false
  let vboxLeft = newBox(Orientation.vertical, 10)
  vboxLeft.homogeneous = false
  let vboxRight = newBox(Orientation.vertical, 10)
  vboxRight.homogeneous = false

  hbox.packStart(vboxLeft, true, true, 0)
  hbox.packStart(vboxRight, true, true, 0)

  let label1 = newLabel(
    "This is a normal label"
    )
  vboxLeft.packStart(label1, true, true, 0)

  let label2 = newLabel(
    "This is a left-justified label.\nWith multiple lines."
    )
  label2.justify = Justification.left
  vboxLeft.packStart(label2, true, true, 0)

  let label3 = newLabel(
    "This is a right-justified label.\nWith multiple lines."
    )
  label3.justify = Justification.right
  vboxLeft.packStart(label3, true, true, 0)

  let label4 = newLabel(
    "This is an example of a line-wrapped label.  It " &
    "should not be taking up the entire             " &
    "width allocated to it, but automatically " &
    "wraps the words to fit.\n" &
    "     It supports multiple paragraphs correctly, " &
    "and  correctly   adds " &
    "many          extra  spaces. "
    )
  label4.lineWrap = true
  vboxRight.packStart(label4, true, true, 0)

  let label5 = newLabel(
    "This is an example of a line-wrapped, filled label. " &
    "It should be taking " &
    "up the entire              width allocated to it.  " &
    "Here is a sentence to prove " &
    "my point.  Here is another sentence. " &
    "Here comes the sun, do de do de do.\n" &
    "    This is a new paragraph.\n" &
    "    This is another newer, longer, better " &
    "paragraph.  It is coming to an end, " &
    "unfortunately."
    )
  label5.lineWrap = true
  label5.justify = Justification.fill
  vboxRight.packStart(label5, true, true, 0)

  let label6 = newLabel()
  label6.markup =
    "Text can be <small>small</small>, <big>big</big>, " &
    "<b>bold</b>, <i>italic</i> and even point to " &
    "somewhere in the <a href=\"https://www.gtk.org\" " &
    "title=\"Click to find out more\">internets</a>."
  label6.lineWrap = true
  vboxLeft.packStart(label6, true, true, 0)

  let label7 = newLabelWithMnemonic(
    "_Press Alt + P to select button to the right"
  )
  vboxLeft.packStart(label7, true, true, 0)
  label7.selectable = true

  let button = newButton("Click at your own risk")
  label7.mnemonicWidget = button
  vboxRight.packStart(button, true, true, 0)

  window.add(hbox)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
