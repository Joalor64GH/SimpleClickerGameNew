package update;

import flixel.text.FlxText;
import flixel.*;
import flixel.util.FlxColor;

class BeforeUpdateState extends FlxState
{
    override public function create()
    {
        super.create();

		var text = new FlxText();
		text.text = "This will be check the version (NEED TO CONNECT TO INTERNET!!!)\n\nPress Enter to start check\nor ESC to exit";
		text.color = FlxColor.PINK;
		text.size = 16;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);
		text.screenCenter();
        add(text);
    }

    override function update(elapsed:Float)
	{
		super.update(elapsed);
    
        if (FlxG.keys.justPressed.ENTER){
            FlxG.switchState(new update.UpdateState());
        }

        if (FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new PlayState());
        }
    }
}