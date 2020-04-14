# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html#headerbar

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "HeaderBar Demo"
  window.borderWidth = 10
  window.defaultSize = (400, 200)

  let hb = newHeaderBar()
  hb.showCloseButton = true
  hb.title = "Headerbar example"
  window.titlebar = hb

  let button1 = newButton()
  let icon = newThemedIcon("mail-send-receive-symbolic")
  let image = newImageFromGicon(cast[Icon](icon), IconSize.button.int)
  button1.add(image)
  hb.packEnd(button1)

  let box = newBox(Orientation.horizontal, 0)
  box.styleContext.addClass("linked")

  let button2 = newButton()
  button2.add(newArrow(ArrowType.left, ShadowType.none))
  box.add(button2)

  let button3 = newButton()
  button3.add(newArrow(ArrowType.right, ShadowType.none))
  box.add(button3)

  hb.packStart(box)

  window.add(newTextView())

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
