var Hapi = require('hapi');
var Good = require('good');
var Path = require('path');

var server = new Hapi.Server();
server.connection({ port: 3000 });
server.views({
    engines: {
        html: require('handlebars')
    },
    path: Path.join(__dirname, 'templates')
});


server.route({
    method: 'GET',
    path: '/',
    handler: function (request, reply) {
        reply('Hello, world!');
    }
});

server.route({
    method: 'GET',
    path: '/car',
    handler: function (request, reply) {
          reply.view('car', { Make: 'Ford' });
    }
});


//Route Optional Parameters
server.route({
    method: 'GET',
    path: '/toy/{whatkind?}',
    handler: function (request, reply) {
       var toy= request.params.whatkind? encodeURIComponent(request.params.whatkind) : 'No Toy';
         reply('My Favorite Toy Is' + toy+ '!');
    
    }
});
//So both toy/ or toy/cars

server.register({
    register: Good,
    options: {
        reporters: [{
            reporter: require('good-console'),
            events: {
                response: '*',
                log: '*'
            }
        }]
    }
}, function (err) {
    if (err) {
        throw err; // something bad happened loading the plugin
    }

    server.start(function () {
        server.log('info', 'Server running at: ' + server.info.uri);
    });
});
