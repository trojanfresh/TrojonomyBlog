
module.exports=function(server){

    server.route({
        method: 'GET',
        path: '/',
        handler: function (request, reply) {
            reply.view('home',{somevar:'Hi'});
        }
    });
    server.route({
        method: 'GET',
        path: '/layout2test',
        handler: function (request, reply) {
            reply.view('home',{somevar:'Hi'},{layout:'layout2'});
        }
    });
    
};