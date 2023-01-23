package update;

import flixel.text.*;
import flixel.*;
import update.UpdateState;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class AfterUpdateState extends FlxState
{
    var text:FlxText;

    override public function create()
    {
        super.create();

		text = new FlxText();
		text.text = "";
		text.color = FlxColor.PINK;
		text.size = 16;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);
		text.screenCenter();
        add(text);
    }

    override function update(elapsed:Float)
	{
		super.update(elapsed);
    
        if (UpdateState.verOld == true){
            text.text = "USING OLD VERSION!!\nPress Enter to go back";
        }else if (UpdateState.verLastest == true){
            text.text = "USING LASTEST VERSION\nPress Enter to go back";
        }else if (UpdateState.verUnknow == true){
            text.text = "Uh...\nPlease check your system again\nBecause we dont know what your os using!\nPress Enter to go back";
        }

        if (FlxG.keys.justPressed.ENTER){
            FlxG.switchState(new PlayState());
        }
    }
}