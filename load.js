var http = require('http');

function startServer(host, port) {  
  http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hey Nginxer!!! You are now docked onto Nodejs port ' + ': ' + port +'\n');
  }).listen(port, host);

  console.log('Hey Nginxer!!! You are now docked onto Nodejs port ' + ': ' + port +'\n');
}

startServer('localhost', 3000);  
startServer('localhost', 3001);  
startServer('localhost', 3002);  