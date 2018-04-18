docReady(function() {
    // see https://mithril.js.org/#components
    // see https://mithril.js.org/components#passing-data-to-components

    //window.data = {};
    //data.count = 0;

    storeSet('count', 0)

    var display = document.getElementById('display');

    var Hello = {
        oninit: function(vnode) {
            this.count_path = vnode.attrs.count_path;
            //this.store = vnode.attrs.store;
        },
        view: function(vnode) {
            var self = this;

            return m("main", [
                m("h1", {class: "title"}, "My first app"),

                // changed the next line
                m("button", {
                    onclick: function() {
                      var count = storeGet(self.count_path);
                      storeSet(self.count_path, count+1);
                    }
                  },
                  storeGet(self.count_path) + " clicks"
                ),
            ])
        }
    }

    m.mount(display, {view: function () {
      return m(Hello, {
        count_path: 'count'/*, store: window._store*/
      })
    }});
});
