package;

import flixel.text.FlxText;
import flixel.FlxState;

class UpdateState extends FlxState{
    var updateVersion:String = '';
    var updateTxt:FlxText;
    var mustUpdate = false;
    var errorOccured = false;

    public function new(){
        private var verCheckTxt:FlxText = new FlxText(0, FlxG.height * 0.9 + 50, FlxG.width,
        "Checking for updates...",
        16);
        verCheckTxt.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, RIGHT);
        verCheckTxt.scrollFactor.set();
        add(verCheckTxt);

        #if desktop
        var http = haxe.Http("https://raw.githubusercontent.com/Hoovy-Team/Simple-Clicker-Game/main/updateVersion.txt");

        http.onData = function(e){
            if(errorOccured) 
                return;
            updateVersion = e.split('\n')[0].trim();
            final curVersion = Main.curVersion.trim();
            trace('version online: ' + updateVersion + ', your version: ' + curVersion);
            if(updateVersion != curVersion) {
                trace('versions arent matching!');
                mustUpdate = true;
            }
        }

        http.onError = function(e){
            trace('an error occurred: $e');
            errorOccured=true;
        }
        #else
        FlxG.switchState(new PlayState());
        trace('no update support available on curPlatform: ' + PlatformUtils.getPlatform());
        #end
    }
}