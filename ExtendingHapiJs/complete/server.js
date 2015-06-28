var Hapi = require('hapi');
var Good = require('good');
var Path = require('path');


var server = new Hapi.Server();
server.connection({ port: 3000 });
server.views({
    engines: {
        html: require('handlebars')
    },
    relativeTo: __dirname,
    path: './views/pages',
    layoutPath: './views/layout',
    layout: true,
    partialsPath: './views/partials',
    helpersPath: './helpers'
});


//require('./routes/routes.js')(server);

var fs=require("fs");
var routePath="./routes/"; //location of our routes
fs.readdirSync(routePath).forEach(function(file) {
    var route=routePath+file; //append routes/ to each js file.
    require(route)(server);//now require it.
});


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