'use strict';

(function () {
  // mithril required
  // store.js is required!

  // https://jamesroberts.name/blog/2010/02/22/string-functions-for-javascript-trim-to-camel-case-to-dashed-and-to-underscore/
  var M, elById, toCamelCase;

  toCamelCase = function toCamelCase(s) {
    return s.replace(/(\-[a-z])/g, function ($1) {
      return $1.toUpperCase().replace('-', '');
    });
  };

  elById = document.getElementById.bind(document);

  M = {
    MAX_AUTOGENERATED_COMPONENT_ID: 2048,
    //instances: {}
    types: {},
    mountById: function mountById(elementId) {
      var componentType, element, instanceData;
      element = elById(elementId);
      //instanceData = M.instances[elementId]
      instanceData = storeGet('ui.' + element.id);
      //instanceData = {}
      componentType = M.types[instanceData.type];
      instanceData.domElementId = elementId;
      componentType.initAttrs(instanceData);
      storeSet('ui.' + element.id, instanceData);
      return m.mount(element, {
        view: function view() {
          return m(componentType, instanceData);
        }
      });
    },
    generateId: function generateId(componentTypeName) {
      var elementId, i, j, ref;
      for (i = j = 1, ref = M.MAX_AUTOGENERATED_COMPONENT_ID; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
        elementId = componentTypeName + i;
        //if not M.instances[elementId]?
        if (storeGet('ui.' + elementId) == null) {
          return elementId;
        }
      }
      return void 0;
    },
    mountToDom: function mountToDom() {
      var attr, componentType, dataKey, e, element, elements, i, instanceData, json_data, ref, results, tagName, typeName;
      ref = M.types;
      results = [];
      for (typeName in ref) {
        componentType = ref[typeName];
        tagName = 'component-' + typeName;
        console.log('tag: ' + tagName);
        //# https://stackoverflow.com/a/15342661/1760643
        //elements = document.querySelectorAll('[data-component]');
        elements = document.querySelectorAll(tagName);
        results.push(function () {
          var j, k, len, ref1, ref2, ref3, results1;
          results1 = [];
          for (j = 0, len = elements.length; j < len; j++) {
            element = elements[j];
            if (!((ref1 = element.id) != null ? ref1.length : void 0)) {
              // autogenerate id
              // TODO to separate function
              //for i in [1 .. M.MAX_AUTOGENERATED_COMPONENT_ID]
              //elementId = typeName + i
              //#if not M.instances[elementId]?
              //if not storeGet('ui.' + elementId)?
              //element.id = elementId
              //break
              element.id = M.generateId(typeName);
            }
            if (!((ref2 = element.id) != null ? ref2.length : void 0)) {
              console.log('Unable to find new elementId for ' + tagName);
              continue;
            }
            json_data = element.getAttribute('data');
            try {
              instanceData = JSON.parse(json_data);
            } catch (error) {
              e = error;
              console.log('Can\'t parse json - ' + json_data + ' - for ' + tagName);
              continue;
            }
            if (instanceData == null) {
              instanceData = {};
            }
            for (i = k = ref3 = element.attributes.length - 1; ref3 <= 0 ? k <= 0 : k >= 0; i = ref3 <= 0 ? ++k : --k) {
              attr = element.attributes[i];
              if (attr.name.match("^data-")) {
                dataKey = toCamelCase(attr.name.substr(5));
                //console.log dataKey
                //console.log attr.name + ': ' + attr.value
                element.removeAttribute(attr.name);
                try {
                  instanceData[dataKey] = JSON.parse(attr.value);
                } catch (error) {
                  e = error;
                  //console.log 'Can\'t parse json - ' + attr.value + ' - for attr ' + attr.name + ' in  #' + element.id
                  //continue
                  instanceData[dataKey] = attr.value;
                }
              }
            }
            element.setAttribute('data', JSON.stringify(instanceData));
            instanceData.type = typeName;
            //M.instances[element.id] = instanceData
            storeSet('ui.' + element.id, instanceData);
            M.mountById(element.id);
            results1.push(console.log('id: ' + element.id));
          }
          return results1;
        }());
      }
      return results;
    }
  };

  window.uiComponents = M;
}).call(undefined);