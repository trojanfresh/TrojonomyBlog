
module.exports=function(server){
    var path = require('path');
    var filename = path.basename(__filename);//here we can get the file name help.js
    filename = filename.replace('.js','');//since it will always have a .js remove it to just get the file name
   //As long as you follow this convention creating a folder in views/pages with a what you add as a route file in routes it will automatically load
    //you do not have to do this, this is just a proof of concept and how I usually have things so that way I know where everything is at without having to dig for code.
    server.route({
        method: 'GET',
        path: '/'+filename+'/subhome',
        handler: function (request, reply) {
            reply.view('./'+filename+'/subhome',{somevar:'Hi From '+filename},{layout:'layout2'});
        }
    });
};