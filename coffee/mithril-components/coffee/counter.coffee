# mithril required
# store.js required
# uiComponents.js required

# see https://mithril.js.org/#components
  # see https://mithril.js.org/components#passing-data-to-components
  #window.data = {};
  #data.count = 0;

  #storeSet 'count1', 0
  #storeSet 'count2', 0

  #elById = document.getElementById.bind(document)

Counter =

  initAttrs: (attrs) ->
    attrs.delta ?= 1
    attrs.defaultCounterValue ?= 7

  oninit: (vnode) ->
    @domElementId = vnode.attrs.domElementId
    #@counterPath = vnode.attrs.counterPath
    #@delta = vnode.attrs.delta or 1
    #this.store = vnode.attrs.store;
    return

  view: (vnode) ->
    attrs = storeGet('ui.' + @domElementId )

    counterPath = attrs.counterPath
    delta = attrs.delta or 1

    #console.log(JSON.stringify(vnode.attrs) + ' rerender')
    self = this
    #m("main", [
    #m("h1", {class: "title"}, "My first app"),
    # changed the next line
#
    #m 'button', { onclick: ->
      #count = storeGet(self.count_path)
      #storeSet self.count_path, count + self.delta
      #return
    #}, self.count_path + ': ' + storeGet(self.count_path)

    deltaCaption = if delta == 1 then '' else '(Δ=' + delta + ') '
    count = storeGet(counterPath)

    if not count?
      storeSet(counterPath, attrs.defaultCounterValue)

    <button
      onclick = {() ->
        count = storeGet(counterPath)
        storeSet(counterPath, count + delta)
      }
    >
      {counterPath + ': ' + deltaCaption + storeGet(counterPath)}
    </button>
    #,
    #)


window.uiComponents.types.counter = Counter


  #m.mount elById('counter1'), view: ->
    #m Hello,
      #count_path: 'count1'
#
  #m.mount elById('counter1_10'), view: ->
    #m Hello,
      #count_path: 'count1',
      #delta: 10
#
  #m.mount elById('counter2'), view: ->
    #m Hello,
      #count_path: 'count2'

  #return

# ---
# generated by js2coffee 2.2.0
