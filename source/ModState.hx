package;

import flixel.*;
import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxColor;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;

class ModState extends FlxState
{
    var have_gamePad:Bool = false;
    var checkText:FlxText;

    override public function create()
    {
        super.create();

        var text = new FlxText(0, 0, 0, "Simple Clicker State - Mods State", 16);
        text.screenCenter(X);
        add(text);

        checkText = new FlxText(5, FlxG.height - 36, 0, "", 16);
        add(checkText);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new PlayState());
        }

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
            checkText.text = "";
            have_gamePad = false;
		} else {
            // trace("Controller detected!, read controller.txt file");
            checkText.text = "Controller detected!";
            have_gamePad = true;
			getControls(gamepad);
		}
    }

    function getControls(gamepad:FlxGamepad) 
    {
        if (have_gamePad == true && gamepad.justPressed.B){
            FlxG.save.flush();
            FlxG.switchState(new PlayState());
        }
    }
}