package update;

import flixel.text.FlxText;
import flixel.system.FlxAssets;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.FlxG;

class UpdateState extends FlxState
{
    var updateVersion:String = '';
    var updateTxt:FlxText;
    var mustUpdate = false;
    var errorOccured = false;

    public static var verOld:Bool = false;
    public static var verLastest:Bool = false;
    public static var verUnknow:Bool = false;

    public function new()
    {
        super();

        var verCheckTxt:FlxText = new FlxText(0, FlxG.height * 0.9 + 50, FlxG.width, "Checking for updates...", 16);
        verCheckTxt.setFormat(FlxAssets.FONT_DEBUGGER, 16, FlxColor.WHITE, RIGHT);
        verCheckTxt.scrollFactor.set();
        add(verCheckTxt);

        #if desktop
        var http = new haxe.Http("https://raw.githubusercontent.com/Joalor64GH/SimpleClickerGameNew/main/updateVersion.txt");

        http.onData = function(e)
        {
            if(errorOccured)
                return;
            updateVersion = e.split('\n')[0].trim();
            final curVersion = Main.curVersion.trim();
            trace('version online: ' + updateVersion + ', your version: ' + curVersion);
            if(updateVersion != curVersion) {
                trace('versions arent matching!');
                mustUpdate = true;
                verOld = true;
                verLastest = false;
                verUnknow = false;
                trace("must update now!");
                FlxG.switchState(new update.AfterUpdateState());
            }else{
                trace("you are using lastest version");
                verOld = false;
                verLastest = true;
                verUnknow = false;
                FlxG.switchState(new update.AfterUpdateState());
            }
        }

        http.onError = function(e){
            trace('an error occurred: $e');
            errorOccured=true;
        }

        http.request();

        #else
        FlxG.switchState(new update.AfterUpdateState());
        verOld = false;
        verLastest = false;
        verUnknow = true;
        trace('no update support available on curPlatform: ' + PlatformUtils.getPlatform());
        #end
    }
}