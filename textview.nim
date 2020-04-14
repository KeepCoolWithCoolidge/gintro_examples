# Based on https://developer.gnome.org/gnome-devel-demos/stable/textview.c.html.en

import gintro / [gtk, gobject, gio]

proc appActivate(app: Application) =
  # Create a window with a title, and a default size
  let window = newApplicationWindow(app)
  window.title = "TextView Example"
  window.defaultSize = (220, 200)

  # The text buffer represents the text being edited
  let buffer = newTextBuffer(nil)

  # Text view is a widget in which can display the text buffer. 
  # The line wrapping is set to break lines in between words.
  let textView = newTextViewWithBuffer(buffer)
  textView.wrapMode = WrapMode.word

  # Create the scrolled window. Usually NULL is passed for both parameters so 
  # that it creates the horizontal/vertical adjustments automatically. Setting 
  # the scrollbar policy to automatic allows the scrollbars to only show up 
  # when needed.
  let scrolledWindow = newScrolledWindow(nil, nil)
  scrolledWindow.setPolicy(PolicyType.automatic, PolicyType.automatic)
  
  # The function directly below is used to add children to the scrolled window 
  # with scrolling capabilities (e.g text_view), otherwise, addWithViewport() 
  # would have been used
  scrolledWindow.add(textView)
  scrolledWindow.borderWidth = 5

  window.add(scrolledWindow)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
