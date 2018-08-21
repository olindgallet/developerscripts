/**
 * Quick script to crawl part time jobs on indeed in New Orleans that are not Uber or Lyft. Change sendmail info near bottom if
 * you want to use it.
 *
 * Plan to hook it up to a cron job and have it send emails to a target gmail account.
 */
const MOMENT     = require('moment');
const REQUEST    = require('request');
const HTMLPARSER = require('htmlparser2');
const SGMAIL     = require('@sendgrid/mail');
 
const WEBSITE = 'https://www.indeed.com/jobs?as_and=part%20time&as_phr&as_any&as_not=uber%20lyft&as_ttl&as_cmp&jt=all&st&salary&radius=25&l=new%20orleans&fromage=any&limit=50&sort=date&psf=advsrch';
const HOST    = 'https://www.indeed.com';

 
let currentTime = MOMENT();

console.log('*****');
console.log("Preparing to crawl: " + WEBSITE); 
console.log("Starting at " + currentTime.format('HH:mm a') + '.');
console.log('*****');

var parser = new HTMLPARSER.Parser({
	htmlText: '',
	plainText: '',
	recordTitle: false,
	recordDescription: false,
	recordPost: false,
	
    onopentag: function(name, attribs){
        if(name === "div" && attribs['data-tn-component'] && attribs['data-tn-component'] === 'organicJob'){
            this.recordPost = true;
			console.log('\n');
			this.plainText = this.plainText + "\r\n\r\n";
			this.htmlText  = this.htmlText + "<br />";
        } else if (name === "a" && this.recordPost && attribs['href'] && !attribs['href'].includes('/reviews') && !attribs['href'].includes('/cmp/')){
			console.log(HOST + attribs['href']);
			this.plainText = this.plainText + HOST + attribs['href'] + "\r\n\r\n";
			this.htmlText  = this.htmlText + HOST + attribs['href'] + "<br />";
			
			if (attribs['data-tn-element'] && attribs['data-tn-element'] === 'jobTitle'){
				this.recordTitle = true;
			}
			
		} else if (name === "span" && this.recordPost && attribs['class'] && attribs['class'] === 'company'){
			this.recordDescription = true;
		}
    }, 
	
	ontext: function(text){
		if (this.recordTitle){
			process.stdout.write(text.trim());
			this.plainText = this.plainText + text.trim();
			this.htmlText  = this.htmlText + text.trim();
		} else if (this.recordDescription){
			process.stdout.write(text.trim());
			this.plainText = this.plainText + text.trim();
			this.htmlText  = this.htmlText + text.trim();
		}
	},
	
	onend: function(){
		console.log("");
		console.log("*****");
		console.log("Completed at " + currentTime.format('HH:mm a') + '.');
		console.log("*****");
		console.log("Emailing to self ...");
		
		SGMAIL.setApiKey('****************SET YOUR API KEY******************');
		const msg = {
			to: '****@****',
			from: '****@****',
			subject: 'Indeed Job Search Report: ' + currentTime.format("MMM Do YY"),
			text: this.plainText,
			html: this.htmlText,
		};
		SGMAIL.send(msg);
		console.log("Email complete");
	},
	
	onclosetag: function(tagname){
		if (tagname === "div"){
			this.recordPost = false;
		} else if (tagname === "a" && this.recordTitle){
			console.log('');
			this.plainText = this.plainText + "\r\n\r\n";
			this.htmlText  = this.htmlText + "<br />";
			this.recordTitle = false;
		} else if (tagname === "span" && this.recordDescription){
			console.log('');
			this.plainText = this.plainText + "\r\n\r\n";
			this.htmlText  = this.htmlText + "<br />";
			this.recordDescription = false;
		}
	}
}, {decodeEntities: true});

REQUEST(WEBSITE, function (error, response, body) {
  if (error){
	console.log("Error happened at " + currentTime.format('HH:mm a') + ': ' + error + '.');
  } else if (response && response.statusCode === 200){
	parser.write(body);
	parser.end();
  }
});
