# Based on https://developer.gnome.org/gnome-devel-demos/stable/spinner.c.html.en

import gintro / [gtk, gdk, gobject, gio, glib]

# Global variable used to indicate active state of the
# spinner. TRUE = active, FALSE = not-active.
var active: bool = true

# This is the callback function. It is a handler function 
# which reacts to the signal. In this case, it will cause the 
# spinner to start and stop according to how many times the user 
# presses the spacebar.
proc keyPressedEvent(window: gtk.ApplicationWindow, event: EventKey, spinner: Spinner): bool =
  var keyval: int
  
  # Extracts the keyval from an event. And stores it in the  variable 
  # "keyval" (we give the function the address). In this case, the 
  # event is GdkEventKey, a key press event
  discard event.getKeyval(keyval)
  if keyval == KEY_space:
    if active:
      spinner.stop()
      active = false
    else:
      spinner.start()
      active = true
  

proc appActivate(app: Application) =
  # Create a window with a title and a default size
  let window = newApplicationWindow(app)
  window.title = "Spinner Example"
  window.defaultSize = (200, 300)
  window.borderWidth = 30
  
  # Create a spinner, with extra horizontal and vertical space
  let spinner = newSpinner()
  spinner.start()

  window.add(spinner)

  # Connecting the key-press-event signal to the callback
  window.connect("key-press-event", keyPressedEvent, spinner)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()