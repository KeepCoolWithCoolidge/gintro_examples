# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html#stack-and-stackswitcher

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Stack Demo"
  window.borderWidth = 10

  let vbox = newBox(Orientation.vertical, 6)
  window.add(vbox)

  let stack = newStack()
  stack.transitionType = StackTransitionType.slideLeftRight
  stack.transitionDuration = 1000

  let checkButton = newCheckButton()
  checkButton.label = "Click me!"
  stack.addTitled(checkButton, "check", "Check Button")

  let label = newLabel()
  label.markup = "<big>A fancy label</big>"
  stack.addTitled(label, "label", "A label")

  let stackSwitcher = newStackSwitcher()
  stackSwitcher.stack = stack
  vbox.packStart(stackSwitcher, true, true, 0)
  vbox.packStart(stack, true, true, 0)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
