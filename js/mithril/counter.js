docReady(function() {
    // see https://mithril.js.org/#components
    // see https://mithril.js.org/components#passing-data-to-components

    window.data = {};
    data.count = 0;

    var display = document.getElementById('display');

    var Hello = {
        view: function(vnode) {
            var count_var_name = vnode.attrs.count;
            var count = window.data[count_var_name];

            return m("main", [
                m("h1", {class: "title"}, "My first app"),
                // changed the next line
                m("button", {onclick: function() {count++}}, count + " clicks"),
            ])
        }
    }

    m.mount(display, {view: function () {return m(Hello, {count: 'count'})}});
});
