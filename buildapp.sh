# Shell script used to create a directory for use in a project.
# Olin Gallet
#
# Assumes npm and bower are installed -- if not, go get them!
# Very Useful >> https://www.shellscript.sh/test.html
# 8/30/2017
TAB="	"
LEFT_CB="{"
RIGHT_CB="}"

ROUTER_INSTRUCTION="//put routing in this file, uses page.js"
ROUTER_SAMPLE="page('/', index);"

HTML_OPEN="<html>"
HTML_CLOSE="</html>"

HEAD_OPEN="${TAB}<head>"
HEAD_CLOSE="${TAB}</head>"

TITLE="${TAB}${TAB}<title>${LEFT_CB}${LEFT_CB} title ${RIGHT_CB}${RIGHT_CB}</title>"

BODY_OPEN="${TAB}<body>"
BODY_DIV_OPEN="${TAB}${TAB}<div id='body'>"
BODY_CONTENTS="${TAB}${TAB}${TAB}${LEFT_CB}${LEFT_CB} body ${RIGHT_CB}${RIGHT_CB}"
BODY_DIV_CLOSE="${TAB}${TAB}</div>";
BODY_CLOSE="${TAB}</body>"

STYLE_SS="${TAB}${TAB}<link rel='stylesheet' type='text/css' href='cssdev/style.css'>"
BOOTSTRAP_SS="${TAB}${TAB}<link rel='stylesheet' type='text/css' href='cssdev/bootstrap.css'>"

BOOTSTRAP_JS="${TAB}${TAB}<script src='jsdev/bootstrap.js'></script>"
JQUERY_JS="${TAB}${TAB}<script src='jsdev/jquery.js'></script>"
VUE_JS="${TAB}${TAB}<script src='jsdev/vue.js'></script>"
APP_JS="${TAB}${TAB}<script src='jsdev/app.js'></script>"
PAGE_JS="${TAB}${TAB}<script src='jsdev/page.js'></script>"

if [ "$1" = "" ]; then
  echo Usage: buildapp [projectname]
  echo
  echo buildapp is used to start up a new app body with Vue.js, Page.js, and Bootstrap for designing and Bower and Grunt for productivity.  
  echo
  echo Made by Olin Gallet September 2017
else
	#create css/cssdev folders
	mkdir $1
	cd $1
	mkdir css
	mkdir cssdev
	cd cssdev
	(echo body{ && echo }) > style.css
	cd ..

	#create assets folders
	mkdir assets
	cd assets
	mkdir image
	mkdir video
	mkdir audio
	cd ..

	#create assetsdev folders
	mkdir assetsdev
	cd assetsdev
	mkdir image
	mkdir video
	mkdir audio
	cd ..

	#create config/configdev folders
	mkdir config
	mkdir configdev
	cd configdev
	(echo "${ROUTER_INSTRUCTION}" && echo "${ROUTER_SAMPLE}") > routing.js
	cd ..
	
	#create js/jsdev folders
	mkdir jsdev
	mkdir js
	cd jsdev
	(echo "var data = ${LEFT_CB}" && \
	 echo "${TAB}title:'Hello World'," && \
	 echo "${TAB}body: 'Start putting stuff for your app here!'" && \
	 echo "${RIGHT_CB};" && \
	 echo "var vm = new Vue(${LEFT_CB}" && \
     echo "${TAB}el: 'head'," && \
	 echo "${TAB}data: data" && \
	 echo "${RIGHT_CB});" && \
	 echo "var vm2 = new Vue(${LEFT_CB}" && \
	 echo "${TAB}el: '#body'," && \
	 echo "${TAB}data: data" && \
	 echo "${RIGHT_CB});") > app.js
	cd ..
	
	(echo "${HTML_OPEN}" && echo "${HEAD_OPEN}" && echo "${TITLE}" && \
	 echo "${STYLE_SS}" && echo "${BOOTSTRAP_SS}" && echo "${HEAD_CLOSE}" && \
	 echo "${BODY_OPEN}" && echo "${BODY_DIV_OPEN}" && echo "${BODY_CONTENTS}" && echo "${BODY_DIV_CLOSE}" && \
	 echo "${VUE_JS}" && echo "${JQUERY_JS}" && echo "${BOOTSTRAP_JS}" && echo "${PAGE_JS}" && echo "${APP_JS}" && echo "${BODY_CLOSE}" && \
	 echo "${HTML_CLOSE}") > index.html 

	#Creates a package.json
	npm init -f
	
	#Install bower dependencies
	curl -L -o bower.json https://gist.githubusercontent.com/olindgallet/131f12ecd23c9d24ce5ae3845c22cd00/raw/2da9346ea78a68ba23e2d25e5a6c902dc1e953c6/basicbower.json
	bower install --save bootstrap
	bower install --save page
	bower install --save vue
	
	#Install grunt dependencies
	curl -L -o gruntfile.js https://gist.githubusercontent.com/olindgallet/46aeacf9f5d6cc1a4fe592438b4b5dd2/raw/24341c9dae9b06cc8def789cc78c19dd69744b28/basicgruntfile.js
	npm install grunt --save-dev
	npm install grunt-contrib-concat --save-dev
	npm install grunt-contrib-uglify --save-dev
	npm install grunt-contrib-copy --save-dev
	npm install grunt-contrib-imagemin --save-dev
	npm install grunt-contrib-clean --save-dev
	
	grunt pullfrombower
fi
