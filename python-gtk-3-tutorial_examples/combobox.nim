# Based on https://python-gtk-3-tutorial.readthedocs.io/en/latest/combobox.html#example

import gintro / [gtk, gobject, gio]
import strformat


const names = [(1, "Billy Bob"),
               (11, "Billy Bob Junior"),
               (12, "Sue Bob"),
               (2, "Joey Jojo"),
               (3, "Rob McRoberts"),
               (31, "Xaviar McRoberts")]

const countries = [ "Austria",
                    "Brazil",
                    "Belgium",
                    "France",
                    "Germany",
                    "Switzerland",
                    "United Kingdom",
                    "United States of America",
                    "Uruguay"]

const currencies = ["Euro",
                    "US dollar",
                    "British pound",
                    "Japanese yen",
                    "Russian ruble",
                    "Mexican peso",
                    "Swiss franc"]

proc onNameComboChanged(combo: ComboBox) =
  var treeIter: TreeIter
  if combo.getActiveIter(treeIter):
    var id: Value
    var name: Value
    combo.model.getValue(treeIter, 0, id)
    combo.model.getValue(treeIter, 1, name)
    echo &"Selected: ID={id.getInt()}, name={name.getString()}"
  else:
    let entry = cast[Entry](combo.getChild()).getText()
    echo &"Entered: {entry}"

proc onCountryComboChanged(combo: ComboBox) =
  var treeIter: TreeIter
  if combo.getActiveIter(treeIter):
    var country: Value
    combo.model.getValue(treeIter, 0, country)
    echo &"Selected: country={country.getString()}"

proc onCurrencyComboChanged(combo: ComboBoxText) =
  let text = combo.getActiveText()
  if text != "":
    echo &"Selected: currency={text}"

proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "ComboBox Example"
  window.borderWidth = 10

  var nameStoreTypes = [typeFromName("gint"), typeFromName("gchararray")]
  var nameStoreIter: TreeIter
  
  var vInt: Value
  var vString: Value
  discard vInt.init(typeFromName("gint"))
  discard vString.init(typeFromName("gchararray"))
  let nameStore = newListStore(2, addr nameStoreTypes)
  
  for element in names:
    nameStore.append(nameStoreIter)
    vInt.int = element[0]
    vString.string = element[1]
    nameStore.setValue(nameStoreIter, 0, vInt)
    nameStore.setValue(nameStoreIter, 1, vString)

  let vbox = newBox(Orientation.vertical, 6)

  let nameCombo = newComboBoxWithModelAndEntry(nameStore)
  nameCombo.connect("changed", onNameComboChanged)
  nameCombo.entryTextColumn = 1
  vbox.packStart(nameCombo, false, false, 0)

  var countryStoreTypes = [typeFromName("gchararray")]
  var countryStoreIter: TreeIter
  let countryStore = newListStore(1, addr countryStoreTypes)
  
  for element in countries:
    countryStore.append(countryStoreIter)
    vString.string = element
    countryStore.setValue(countryStoreIter, 0, vString)

  let countryCombo = newComboBoxWithModel(countryStore)
  countryCombo.connect("changed", onCountryComboChanged)
  let rendererText = newCellRendererText()
  countryCombo.packStart(rendererText, true)
  countryCombo.addAttribute(rendererText, "text", 0)
  vbox.packStart(countryCombo, false, false, 1)

  let currencyCombo = newComboBoxText()
  currencyCombo.entryTextColumn = 0
  currencyCombo.connect("changed", onCurrencyComboChanged)
  for currency in currencies:
    currencyCombo.appendText(currency)
  vbox.packStart(currencyCombo, false, false, 0)

  window.add(vbox)

  window.showAll()

proc main =
  let app = newApplication("org.gtk.example")
  app.connect("activate", appActivate)
  discard app.run()

main()
