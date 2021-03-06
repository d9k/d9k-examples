window._store = {}

//function explode( delimiter, string ) {	// Split a string by string
////
//	 //+   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
//	 //+   improved by: kenneth
//	 //+   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
//
	//var emptyArray = { 0: '' };
//
	//if ( arguments.length != 2
		//|| typeof arguments[0] == 'undefined'
		//|| typeof arguments[1] == 'undefined' )
	//{
		//return null;
	//}
//
	//if ( delimiter === ''
		//|| delimiter === false
		//|| delimiter === null )
	//{
		//return false;
	//}
//
	//if ( typeof delimiter == 'function'
		//|| typeof delimiter == 'object'
		//|| typeof string == 'function'
		//|| typeof string == 'object' )
	//{
		//return emptyArray;
	//}
//
	//if ( delimiter === true ) {
		//delimiter = '1';
	//}
//
	//return string.toString().split ( delimiter.toString() );
//}

//function storeNodeExists(path) {
  //var pathParts = path.split('.');
  //var curentPointer = window._store;
  //for (var i = 0; i < pathParts.length; i++) {
    //var pathPart = pathParts[i];
//
     ////console.log();
    //if curentPointer.hasOwnProperty(pathPart) {
      //curentPointer = curentPointer[pathPart];
    //} else {
      //return false;
    //}
  //}
  //return true;
//}

function localStoreGet(store, path) {
  var pathParts = path.split('.');
  //var curentPointer = window._store;
  var curentPointer = store;
  for (var i = 0; i < pathParts.length; i++) {
    var pathPart = pathParts[i];

    // console.log();
    if (!curentPointer.hasOwnProperty(pathPart)) {
      return undefined;
    }
    curentPointer = curentPointer[pathPart];
  }
  return curentPointer;
}

function localStoreSet(store, path, value) {
  var pathParts = path.split('.');
  //var curentPointer = window._store;
  var curentPointer = store;
  for (var i = 0; i < pathParts.length; i++) {
    var pathPart = pathParts[i];

    // console.log();
    if (i < pathParts.length - 1) {
      if (!curentPointer.hasOwnProperty(pathPart)) {
        curentPointer[pathPart] = {};
      }
      curentPointer = curentPointer[pathPart];
    } else {
      curentPointer[pathPart] = value;
    }
  }
}

function storeGet(path) {
//  var pathParts = path.split('.');
//  var curentPointer = window._store;
//
//  for (var i = 0; i < pathParts.length; i++) {
//    var pathPart = pathParts[i];
//
//    // console.log();
//    if (!curentPointer.hasOwnProperty(pathPart)) {
//      return undefined;
//    }
//    curentPointer = curentPointer[pathPart];
//  }
//  return curentPointer;
  return localStoreGet(window._store, path);
}

function storeSet(path, value) {
//  var pathParts = path.split('.');
//  var curentPointer = window._store;
//
//  for (var i = 0; i < pathParts.length; i++) {
//    var pathPart = pathParts[i];
//
//    // console.log();
//    if (i < pathParts.length - 1) {
//      if (!curentPointer.hasOwnProperty(pathPart)) {
//        curentPointer[pathPart] = {};
//      }
//      curentPointer = curentPointer[pathPart];
//    } else {
//      curentPointer[pathPart] = value;
//    }
//  }
  // if value is object, assign recursively, see https://github.com/jonschlinkert/assign-deep
  //curentPointer = value;
  return localStoreSet(window._store, path, value);
}

