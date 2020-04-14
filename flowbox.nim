# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/layout.html#flowbox

import gintro / [gtk, gdk, gobject, gio, cairo, glib]

proc onDraw(area: DrawingArea, cr: Context, rgba: RGBA): bool =
  let context = area.getStyleContext()

  let width = area.getAllocatedWidth().float
  let height = area.getAllocatedHeight().float
  context.renderBackground(cr, 0, 0, width, height)
  cr.setSource(rgba.red, rgba.green, rgba.blue, rgba.alpha)
  cr.rectangle(0, 0, width, height)
  cr.fill()
  true

proc newColorSwatch(colorStr: string): Button =
  var rgba: RGBA
  discard rgba.parse(colorStr)
  let button = newButton()

  let area = newDrawingArea()
  area.setSizeRequest(24, 24)
  area.connect("draw", onDraw, rgba)

  button.add(area)
  button

proc createFlowbox(flowbox: FlowBox) =
  let colors = ["AliceBlue",
                "AntiqueWhite",
                "AntiqueWhite1",
                "AntiqueWhite2",
                "AntiqueWhite3",
                "AntiqueWhite4",
                "aqua",
                "aquamarine",
                "aquamarine1",
                "aquamarine2",
                "aquamarine3",
                "aquamarine4",
                "azure",
                "azure1",
                "azure2",
                "azure3",
                "azure4",
                "beige",
                "bisque",
                "bisque1",
                "bisque2",
                "bisque3",
                "bisque4",
                "black",
                "BlanchedAlmond",
                "blue",
                "blue1",
                "blue2",
                "blue3",
                "blue4",
                "BlueViolet",
                "brown",
                "brown1",
                "brown2",
                "brown3",
                "brown4",
                "burlywood",
                "burlywood1",
                "burlywood2",
                "burlywood3",
                "burlywood4",
                "CadetBlue",
                "CadetBlue1",
                "CadetBlue2",
                "CadetBlue3",
                "CadetBlue4",
                "chartreuse",
                "chartreuse1",
                "chartreuse2",
                "chartreuse3",
                "chartreuse4",
                "chocolate",
                "chocolate1",
                "chocolate2",
                "chocolate3",
                "chocolate4",
                "coral",
                "coral1",
                "coral2",
                "coral3",
                "coral4"]
  
  for color in colors:
    let button = newColorSwatch(color)
    flowbox.add(button)

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "FlowBox Demo"
  window.borderWidth = 10
  window.defaultSize = (300, 250)

  let header = newHeaderBar()
  header.title = "Flow Box"
  header.subtitle = "Sample FlowBox app"
  header.showCloseButton = true

  window.titlebar = header

  let scrolled = newScrolledWindow()
  scrolled.setPolicy(PolicyType.never, PolicyType.automatic)

  let flowbox = newFlowBox()
  flowbox.valign = Align.start
  flowbox.maxChildrenPerLine = 30
  flowbox.selectionMode = SelectionMode.none

  flowbox.createFlowbox()
  scrolled.add(flowbox)

  window.add(scrolled)
  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
