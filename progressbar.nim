import gintro / [gtk, gobject, gio, glib]

proc fill(progressBar: ProgressBar): bool =
  # Get the current progress
  var fraction = progressBar.fraction

  # Increase the bar by 10% each time this function is called
  fraction += 0.1

  # Fill in the bar with the new fraction
  progressBar.fraction = fraction

  # Ensures that the fraction stays below 1.0
  if fraction < 1.0:
    return true
  return false

proc appActivate(app: Application) =
  # Create a window with a title and a default size
  let window = newApplicationWindow(app)
  window.title = "ProgressBar Example"
  window.defaultSize = (220, 20)

  var fraction = 0.0

  # Create a progressbar and add it to the window
  let progressBar = newProgressBar()
  window.add(progressBar)

  # Fill in the given fraction of the bar. Has to be between 0.0-1.0 inclusive
  progressBar.fraction = fraction

  # Use the created fill function every 500 milliseconds
  timeoutAdd(500, fill, progressBar)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()