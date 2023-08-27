let counter = 0;

var ports = [];

function timedCount() {
  counter = counter + 1;

  for (var i = 0; i < ports.length; i++) {
    ports[i].postMessage(counter);
  }

  setTimeout("timedCount()", 500);
}

timedCount();

self.onconnect = (e) => {
  var port = e.ports[0];

  ports.push(port);

  port.onmessage = (e) => {
    if (e.data == 'terminate') {
      self.close();
    }
  };

  port.start();

  timedCount();
}


