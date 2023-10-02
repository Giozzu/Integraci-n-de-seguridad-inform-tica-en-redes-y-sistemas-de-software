//help me build an RESTFUl API 

// Dependencies

var http = require('http');
var url = require('url');
var StringDecoder = require('string_decoder').StringDecoder;

// The server should respond to all requests with a string

var server = http.createServer(function(req,res){

}

// Start the server, and have it listen on port 3000

server.listen(3000,function(){
  console.log('The server is listening on port 3000 now');
});

// Define a request router

var router = {
    'sample' : handlers.sample
    }

// Define the handlers

var handlers = {};

// Sample handler

handlers.sample = function(data,callback){
    // Callback a http status code, and a payload object
    callback(406,{'name' : 'sample handler'});
    }

// Not found handler

handlers.notFound = function(data,callback){
    callback(404);
    }

// Define a request router

var router = {
    'sample' : handlers.sample
    }

// Define the handlers

var handlers = {};  // Sample handler

handlers.sample = function(data,callback){
    // Callback a http status code, and a payload object
    callback(406,{'name' : 'sample handler'});
    }

// Not found handler
