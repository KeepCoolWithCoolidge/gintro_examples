import gintro / [gtk, gobject, gio, glib]

proc aboutCallback(simple: SimpleAction, parameter: Variant) =
  echo "You clicked \"About\""

proc newCallback(simple: SimpleAction, parameter: Variant) =
  echo "You clicked \"New\""

proc quitCallback(simple: SimpleAction, parameter: Variant, app: Application) =
  app.quit()

proc startup(app: Application) =
  let newAction = newSimpleAction("new", nil)
  discard newAction.connect("activate", newCallback)
  app.addAction(newAction)

  let quitAction = newSimpleAction("quit", nil)
  discard quitAction.connect("activate", quitCallback, app)
  app.addAction(quitAction)

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  let grid = newGrid()

  window.title = "MenuButton Example"
  window.defaultSize = (600, 400)

  let menuButton = newMenuButton()
  menuButton.setSizeRequest(80, 35)

  grid.attach(menuButton, 0, 0, 1, 1)
  window.add(grid)

  let menuModel = gio.newMenu()
  menuModel.append("New", "app.new")
  menuModel.append("About", "win.about")

  let subMenu = gio.newMenu()
  menuModel.appendSubmenu("Other", subMenu)
  menuModel.append("Quit", "app.quit")
  menuButton.setMenuModel(menuModel)

  let aboutAction = newSimpleAction("about", nil)
  discard aboutAction.connect("activate", aboutCallback)
  cast[ActionMap](window).addAction(aboutAction)
  
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  app.connect("startup", startup)
  discard run(app)

main()