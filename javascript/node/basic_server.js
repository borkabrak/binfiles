var http = require('http');

var server = http.createServer(function(request, response){
  response.writeHead(200);
  console.log("Request received: %o", request);
  response.end("It's alive!");

  var data = '';
  request
    .on('data', function(chunk){
      console.log("data fired");
      data += chunk;
    })
    .on('end', function(){
      console.log("end fired");
      console.log("Data: %s", data);
    })

});

server.listen(8080);
