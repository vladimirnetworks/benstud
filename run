var http = require("http"),
    url = require("url"),
    path = require("path"),
    fs = require("fs"),
    port = process.argv[2] || 8888;


const { exec } = require("child_process");



http.createServer(function(request, response) {

    var uri = url.parse(request.url).pathname
    var filename2 = path.join(process.cwd(), uri);
    var filename = path.dirname(require.main.filename)+uri

console.log(filename);


    var re = new RegExp('/gen/(.*)');
    var r = request.url.match(re);

    if (r) {

        var body = ''
        request.on('data', function(data) {
            body += data

            var base64Data = body.replace(/^data:image\/png;base64,/, "");

            require("fs").writeFile(r[1] + ".png", base64Data, 'base64', function(err) {
                console.log(err);
            });
        })


        response.writeHead(200);
        response.write("ok");
        response.end();
        return
    }

    if (request.url == '/cmd') {
        response.writeHead(200);

        request.on('data', function(data) {

            //const myArray = data.split("^^");

           console.log("run"+data);
            exec(data + "", (error, stdout, stderr) => {
                if (error) {
                    console.log(`error: ${error.message}`);
                    return;
                }
                if (stderr) {
                    console.log(`stderr: ${stderr}`);
                    return;
                }
                console.log(`stdout: ${stdout}`);
            });


        })

        response.write("run");
        response.end();



    }

    fs.exists(filename, function(exists) {
        if (!exists) {
            response.writeHead(404, { "Content-Type": "text/plain" });
            response.write(request.url + "404 Not Found\n");
            response.end();
            return;
        }

        if (fs.statSync(filename).isDirectory()) filename += '/app';

        fs.readFile(filename, "binary", function(err, file) {
            if (err) {
                response.writeHead(500, { "Content-Type": "text/plain" });
                response.write(err + "\n");
                response.end();
                return;
            }

            response.writeHead(200);
            response.write(file, "binary");
            response.end();
        });
    });
}).listen(parseInt(port, 10));

var childProc = require('child_process');
childProc.exec('/usr/bin/google-chrome-stable "http://localhost:8888/"');

console.log("server running at\n  => http://localhost:" + port + "/\n");
