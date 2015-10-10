/*
	author: Matteo Pallotta
*/

//installare il modulo i moduli sul server (e.g.): sudo npm install ncp
var mv = require('mv');
var Promise = require('lie');
var fs = require('fs');
var sleep = require('sleep');
var sys = require('sys')
var exec = require('child_process').exec;
var readline = require('readline');
var ncp = require('ncp').ncp;
ncp.limit = 32;

var adaptFile = function (filePath, nomeComune) {
	return new Promise(
        function(resolve, reject) {
        	fs.readFile(filePath, 'utf-8', function(err, data){

                if (err) {
                    console.log('[ERROR] file not read');
                    return;
                } 
                var result = data.replace(/(D|d)ocrs/g, nomeComune);
                fs.writeFile(filePath, result, 'utf-8', function (err) {
                	resolve();
                    if (err) console.log('[ERROR] file not created');                
                });
        	});
        }
    );
}

function createDB(DBname) {
	function puts(error, stdout, stderr) { sys.puts(stdout) }
	exec('mysql -uroot -e "create database ' + DBname + '"', puts); //TODO: PASSWORD
}

var initUsers = function(name) {
	return new Promise(
		function(resolve, reject) {
			function puts(error, stdout, stderr) { sys.puts(stdout) }
			exec("mysql -uroot " + name + " < queries" , puts); //TODO: PASSWORD
			resolve();
		}
	);
}

var move = function(src, dst) {
	return new Promise(
		function(resolve, reject) {
			mv(src, dst, function(err) {
				if (err) console.log('[ERROR] file not moved'); 
				resolve();
			});
		}
	);
}

var copy = function(src, dst) {
	return new Promise(
		function(resolve, reject) {
			ncp(src, dst, function(err) {
				if (err) console.log('[ERROR] file not copied'); 
				resolve();
			});
		}
	);
}

var createInstance = function(dst, logoPath) {
	return new Promise(
		function(resolve, reject) {
			ncp('./docrs',('./'+dst), function(err) {
		        if(err) {
		            console.log('[ERROR] folder not copied');
		            return;
		        } else {
		            createDB(dst);
		            adaptFile('./'+ dst +'/META-INF/maven/com.programmingfree/docrs/pom.xml',dst).then(
		            	function(){adaptFile('./'+ dst +'/META-INF/maven/com.programmingfree/docrs/pom.properties',dst).then(
		            		function(){adaptFile('./'+ dst +'/WEB-INF/classes/application.properties',dst).then(
		            			function(){adaptFile('./'+ dst +'/WEB-INF/classes/static/js/main.js',dst).then(
		            				function(){adaptFile('./'+ dst +'/WEB-INF/index.html',dst).then(
		            					function(){adaptFile('./'+ dst +'/WEB-INF/login.html',dst).then(
		            				  		function(){copy(logoPath, './'+ dst +'/WEB-INF/classes/static/images/logo_comune.png').then(
		            				  			function(){
		            				  				resolve();
		            							}
		            						);}
		            					);}
		            				);}
		            			);}
		            		);}
		            	);}
		           	);
	    	    }
	    	});
		}
	);  
}

var getLastLine = function() {
	return new Promise(
		function(resolve,reject) {
			fs.readFile('../../logs/catalina.out', 'utf-8', function(err, data) {
			    if (err) throw err;

			    var lines = data.trim().split('\n');
			    var lastLine = lines.slice(-1)[0];
			    
			    resolve(lastLine);
			});
		}
	);
}

function regex(line, appName) {
	var match = line.match('^.*'+appName+' has finished in .* ms$');
	return (match !== null);
}

function userInterface(name){ 
	promise = getLastLine();
	promise.then(function(ll){
		installed = regex(ll, name);
	}).then(function(){
		process.stdout.write('. ');
	}).then(function(){
		sleep.sleep(2);
	}).then(function(resolve, reject){
		if(!installed)
			userInterface(name);
		else{
			initUsers(name).then(
				function(){
					console.log('\nINFO: THE INSTANCE HAS BEEN SUCCESSFULLY INSTALLED!\n\n####');
				}
			);
		}
	});
}

function install() {
	console.log('####\n');
	var r1 = readline.createInterface({
	  input: process.stdin,
	  output: process.stdout
	});

	r1.question('TYPE: INSERT THE NAME OF THE NEW INSTANCE (e.g: Roma): ', function(name) {
		r1.close();
		var r2 = readline.createInterface({
	  		input: process.stdin,
	  		output: process.stdout
		});
		r2.question('TYPE: INSERT THE ABSOLUTE LOGO PATH\n(must be a PNG file, e.g: /home/user/../logo.png): ', function(logo) {
	  		r2.close();
	  		console.log('INFO: INSTALLING THE NEW INSTANCE');
	  		createInstance(name, logo).then(function(){
	  			move('./'+name, '../'+name);
				userInterface(name);		
	  		});
		});
	});
}

install();