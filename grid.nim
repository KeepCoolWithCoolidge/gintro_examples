# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html#grid

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Grid Example"

  let grid = newGrid()
  window.add(grid)

  let button1 = newButton("Button 1")
  let button2 = newButton("Button 2")
  let button3 = newButton("Button 3")
  let button4 = newButton("Button 4")
  let button5 = newButton("Button 5")
  let button6 = newButton("Button 6")

  grid.add(button1)
  grid.attach(button2, 1, 0, 2, 1)
  grid.attachNextTo(button3, button1, PositionType.bottom, 1, 2)
  grid.attachNextTo(button4, button3, PositionType.right, 2, 1)
  grid.attach(button5, 1, 2, 1, 1)
  grid.attachNextTo(button6, button5, PositionType.right, 1, 1)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
