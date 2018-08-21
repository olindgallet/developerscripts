# developerscripts
Scripts for developers to increase productivity -- spend more time coding, less time configuring!

Author: Olin Gallet

Project Started: 9/1/2017

# buildapp (Beta Version, Released 9/1/2017)

Sets up a work directory for a webapp with a Bootstrap, Vue, and Page stack.  Adds in Bower and Grunt for tasks and updates.  Provides directory for development and production; the plan is to use Grunt to take desired files from the development folders, compress and obfuscate them, and put them inproduction.

Notes:

-Hard coded some file creation and tried out downloading some files from Gists.  I noticed that with even one small change the filename for the gist would change.  I wonder if I can use another link, but as of now I need the raw version of the file.

-Currently testing it out by making apps with it.  Never used Vue and Page either, but I chose this stack after looking at the other frameworks in Javascript.  I'll put some apps I'm making in it up also as time progresses.

# buildgame (Beta Version, Released 9/4/2017)

Sets up a work directory for a game using Canvas with Easel.js, Sound.js, Preload.js and some homespun classes for graphics.  Also uses Keyboard.js and gamepadAPI for control options.

Notes:

-The command "grunt builddevelopment" must be run once so that main.js can be created.  All it does is combine the javascript files together to one file.

-Where to get started?  Look at PlayScreen/PlayScreenDrawer.

# jobsearch (Beta Version, Released 8/21/2018)

Does a quick job search through indeed.com.  Original version was done in PHP, but new version is in Node.js.  Uses SendGrid to send mail regarding jobs to an email.  Hook this up to a cron job for automated job updates on your terms.
