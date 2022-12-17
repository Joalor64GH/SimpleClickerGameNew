package;

import flixel.FlxG;
import lime.utils.Assets;

using StringTools;

class SystemData
{
    public static var ownItem:Bool = true;

    public function new(){

    }

    public static inline function stringFile(path:String):String
    {
        var fileAssets:String = Assets.getText(path).trim();
        
        return fileAssets;
    }

    inline public static function coin()
    {
        if (FlxG.save.data.coin == null)
            FlxG.save.data.coin = 0;
    }

    inline static public function saveData()
    {
        /*if (FlxG.save.data.x2 == null)
            FlxG.save.data.x2 = 0; 

        if (FlxG.save.data.autoTap == null)
            FlxG.save.data.autoTap = 0;*/

        // limitNumber();

        if (FlxG.save.data.x2 == null)
            FlxG.save.data.x2 = false; 

        if (FlxG.save.data.autoTap == null)
            FlxG.save.data.autoTap = false;
    }

    inline static public function limitNumber()
    {
        if (FlxG.save.data.x2 == 2)
        {
            FlxG.save.data.x2 == 0;
        }

        if (FlxG.save.data.autoTap == 2)
        {
            FlxG.save.data.autoTap == 0;
        }
    }
}