# Based on https://developer.gnome.org/gnome-devel-demos/stable/statusbar.c.html.en

import gintro / [gtk, gobject, gio]

# Callback function in which pushes an item onto the statusbar
proc pushItem(button: Button, statusBar: StatusBar) =
  # Create a context id, which is used to uniquely identify
  # the source of a message
  let contextId = statusBar.contextId("Statusbar example")

  # Count is used to keep track of the amount of items
  # the user is pushing/popping
  var count {.global.} = 1;
  
  # The output is guaranteed in this case to not exceed 20 characters, 
  # and the result is stored into the 'holdOutput' variable
  var holdOutput = newString(20)
  let str = "Item " & $count
  inc count
  for i, _ in str: holdOutput[i] = str[i]
  discard statusBar.push(contextId, holdOutput)

# Callback function that is used to pop an item off the statusbar
proc popItem(button: Button, statusBar: StatusBar) =
  let contextId = statusBar.contextId("Statusbar example")
  statusBar.pop(contextId)

proc appActivate(app: Application) =

  # Create a window with a title, border width, and a default size
  let window = newApplicationWindow(app)
  window.defaultSize = (220, 100)
  window.title = "StatusBar Example"
  window.borderWidth = 10

  # Create the status bar, which is held in the global variable
  let statusBar = newStatusBar()

  # Create the buttons with labels
  let pushButton = newButton("push item")
  let popButton = newButton("pop last item")

  # Create the grid, and attach the buttons/statusbar accordingly
  let grid = newGrid()
  grid.attach(pushButton, 0, 1, 1, 1)
  grid.attach(popButton, 0, 2, 1, 1)
  grid.attach(statusBar, 0, 3, 1, 1)

  # Connecting the clicked signals to the corresponding callback functions
  discard pushButton.connect("clicked", pushItem, statusBar)
  discard popButton.connect("clicked", popItem, statusBar)
  
  # Attach the grid holding the child widgets onto the window, and show all
  window.add(grid)
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  connect(app, "activate", appActivate)
  discard run(app)

main()