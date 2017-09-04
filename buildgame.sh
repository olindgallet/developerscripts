# Shell script used to create a directory for use in making a Javascript game.
# Olin Gallet
#
# Assumes npm and bower are installed -- if not, go get them!
# Very Useful >> https://www.shellscript.sh/test.html
# 8/30/2017
TAB="	"
LEFT_CB="{"
RIGHT_CB="}"

HTML_OPEN="<html>"
HTML_CLOSE="</html>"

HEAD_OPEN="${TAB}<head>"
HEAD_CLOSE="${TAB}</head>"

TITLE="<title>Insert Game Title Here</title>"

BODY_OPEN="${TAB}<body>"
BODY_DIV_OPEN="${TAB}${TAB}<div id='body'>"
canvas_width=1280
canvas_height=720
BODY_DIV_CLOSE="${TAB}${TAB}</div>";
BODY_CLOSE="${TAB}</body>"

if [ "$1" = "" ]; then
  echo Usage: buildgame [projectname] [optional: width] [optional: height]
  echo
  echo buildapp is used to start up a new game with the Create.js suite and various tools for productivity.
  echo
  echo Made by Olin Gallet September 2017
  exit 0;
fi

if [ "$2" != "" -a "$3" != "" ]; then
  canvas_width=$2
  canvas_height=$3
fi
	
#create css/cssdev folders
mkdir $1
cd $1
mkdir css
cd css
(echo "body ${LEFT_CB}" && \
 echo "${TAB}margin 0 0 0 0;" && \
 echo "${TAB}padding 0 0 0 0;" && \
 echo "${TAB}overflow: hidden;" && \
 echo "${RIGHT_CB}" && \
 echo "canvas ${LEFT_CB}" && \
 echo "${TAB}background: #000;" && \
 echo "${TAB}width: ${canvas_width}px;" && \
 echo "${TAB}height: ${canvas_height}px;" && \
 echo "${TAB}margin: 0 0 0 0;" && \
 echo "${TAB}padding: 0 0 0 0;" && \
 echo "${RIGHT_CB}") > style.css
cd ..

#create assets folder
mkdir assets
cd assets
mkdir image
mkdir video
mkdir audio
cd ..

#create assetsdev folder
mkdir assetsdev
cd assetsdev
mkdir image
mkdir video
mkdir audio
cd ..

#create jsdev/jsdev folders
mkdir jsdev
cd jsdev

mkdir gui
cd gui

mkdir all
cd all
curl -L -o Animation.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/Animation.js
curl -L -o AudioConstants.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/AudioConstants.js
curl -L -o AudioPlayer.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/AudioPlayer.js
curl -L -o Canvas.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/Canvas.js
curl -L -o GraphicsConsants.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/GraphicsConstants.js
curl -L -o OffscreenBuffer.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/OffscreenBuffer.js
curl -L -o SpriteSheet.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/all/SpriteSheet.js
cd ..

mkdir screens
cd screens
curl -L -o PlayScreen.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/playscreen/PlayScreen.js
curl -L -o PlayScreenDrawer.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/playscreen/PlayScreenDrawer.js
cd ..

mkdir utilities
cd utilities
curl -L -o AssetLoader.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/utilities/AssetLoader.js
curl -L -o FrameTimer.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/utilities/FrameTimer.js
curl -L -o TextUtilities.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gui/utilities/TextUtilities.js
cd ..
cd ..

mkdir input
cd input 
curl -L -o GameControls.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/input/GameControls.js
curl -L -o gamepadAPI.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/input/gamepadAPI.js
curl -L -o InputObserver.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/input/InputObserver.js
curl -L -o xbox-gamepad.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/input/xbox-gamepad.js
cd ..
cd ..

mkdir js

(echo "<!DOCTYPE html>" && \
 echo "<html>" && \
 echo "${TAB}<head>" && \
 echo "${TAB}${TAB}<link rel='stylesheet' type='text/css' href='css/style.css' />" && \
 echo "${TAB}${TAB}<meta charset='utf-8'>" && \
 echo "${TAB}${TAB}<title>" && \
 echo "${TAB}${TAB}${TAB}Your Game Title Here" && \
 echo "${TAB}${TAB}</title>" && \
 echo "${TAB}</head>" && \
 echo "<body>" && \
 echo "${TAB}<div id='canvas-panel'>" && \
 echo "${TAB}${TAB}<canvas id='drawing'></canvas>" && \
 echo "${TAB}</div>" && \
 echo "${TAB}<script type='text/javascript' src='js/main.js'></script>" && \
 echo "${TAB}</body>"
 echo "</html>") > index.html;
#Creates a package.json
npm init -f

#Install bower dependencies
curl -L -o bower.json https://gist.githubusercontent.com/olindgallet/131f12ecd23c9d24ce5ae3845c22cd00/raw/2da9346ea78a68ba23e2d25e5a6c902dc1e953c6/basicbower.json
bower install --save create-js
bower install --save keypress

#Install grunt dependencies
curl -L -o gruntfile.js https://raw.githubusercontent.com/olindgallet/js-game-utilities/master/gamegruntfile.js
npm install grunt --save-dev
npm install grunt-contrib-concat --save-dev
npm install grunt-contrib-uglify --save-dev
npm install grunt-contrib-copy --save-dev
npm install grunt-contrib-imagemin --save-dev
npm install grunt-contrib-clean --save-dev
npm install grunt-spritesmith --save-dev

grunt pullfrombower