// A simple web server from nodejs' web site

var http = require('http');
var fs = require('fs');
var index = fs.readFileSync('index.html');
var domain = '127.0.0.1';
var port = '82';

http.createServer(function (req, res) {

  res.writeHead(200, {'Content-Type': 'text/html'});
  res.end(index);
  
}).listen(82, domain);
console.log('Server running at http://' + domain + ':' + port + '/');
