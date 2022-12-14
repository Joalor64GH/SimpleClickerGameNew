package;

import flixel.system.FlxAssets;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class OutDateState extends FlxState
{
    override function create() 
    {
        var txt:FlxText = new FlxText(0, 0, FlxG.width,
            "You are using a old Simple Clicker Game!"
            + "\n\nNew version are release!"
            + "\n\nPress Enter to go to github page\nPress ESC to back check state",
			32);
		txt.setFormat(FlxAssets.FONT_DEFAULT, 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
    }

    override function update(elapsed:Float)
	{
        var enter = FlxG.keys.justPressed.ENTER;
        var esc = FlxG.keys.justPressed.ESCAPE;

		if (enter)
		{
			FlxG.openURL("https://github.com/Hoovy-Team/Simple-Clicker-Game");
		}
		if (esc)
		{
			FlxG.switchState(new CheckState());
		}
        
		super.update(elapsed);
	}
}