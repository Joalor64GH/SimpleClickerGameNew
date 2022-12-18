package;

import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxColor;
import flixel.system.FlxAssets;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.*;

class PlayState extends FlxState
{
    public static var gamepad:FlxGamepad;

    public static var sprite:Sprite_Game;
    public static var sprite_tween:FlxTween;
    public static var coinTxt:FlxText;
    var checkText:FlxText;

    override public function create()
    {
        super.create();

        SystemData.coin(); //when first playing, number of coin are null
        SystemData.saveData();
        // checkController();
        var text = new FlxText(0, 0, 0, "Simple Clicker Game", 32);
        text.screenCenter(X);
        add(text);

        coinTxt = new FlxText(5, FlxG.height - 18, 0, 
            "Coin: " + FlxG.save.data.coin +
            if (FlxG.save.data.autoTap == true)
                " | Auto Tap is Enable";
            else if (FlxG.save.data.autoTap == false)
                "";
            else
                "", 16);
        add(coinTxt);

        checkText = new FlxText(5, FlxG.height - 36, 0, "", 16);
        add(checkText);

        sprite = new Sprite_Game(0, 0, "button");
        sprite.screenCenter();
        add(sprite);

        if (FlxG.sound.music == null || !FlxG.sound.music.playing) // don't restart the music if it's already playing
        {
            // idk should we add more then one song??
            FlxG.sound.playMusic(Paths.music('buttonClicker'), 1, true);
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        coinTxt.text = "Coin: " + FlxG.save.data.coin + 
        if (FlxG.save.data.autoTap == true) 
            " | Auto Tap is Enable";
        else if (FlxG.save.data.autoTap == false)
            "";
        else
            "";

        var options = FlxG.keys.justPressed.Q;
        var press = FlxG.keys.justPressed.ENTER;
        var press_alt = FlxG.keys.justPressed.SPACE;
        var store = FlxG.keys.justPressed.S;
        var reset = FlxG.keys.justPressed.R;
        var devThing = FlxG.keys.justPressed.L;

        if (options)
        {
            FlxG.switchState(new OptionsState());

            FlxG.save.flush();
        }

        if (store)
        {
            trace('wellcome');

            FlxG.switchState(new StoreState());

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }

            FlxG.save.flush();
        }

        if (press || press_alt || FlxG.mouse.overlaps(sprite) && FlxG.mouse.justPressed || autoTap() && FlxG.elapsed % 2 == 0)
        {
            sprite.animation.play('tap');

            if (FlxG.save.data.x2 == true)
                FlxG.save.data.coin += 2;
            else
                FlxG.save.data.coin++;

            FlxG.save.flush();
        }

        if (reset){
            FlxG.save.data.coin = 0;
            FlxG.save.data.autoTap = 0;
            FlxG.save.data.x2 = 0;
            SystemData.ownItem = false; 
            FlxG.sound.play(Paths.sound('resetSound'), 1);

            // openSubState(new ResetState());
        }

        if (devThing){
            // #if sys
            // if (Sys.args().contains('dev mode')){
            //     FlxG.save.data.coin += 9999;
            // }
            // #else
            // trace('you do not have dev mode enabled');
            // #end
            // so like hack system
            #if macro
            if (@:privateAccess Macros.getDefine('dev mode')){//I'm too lazy
                FlxG.save.data.coin += 9999;
            }
            else {
                trace('you do not have dev mode enabled');
            }
            #else
            trace('platform does not support dev mode');
            #end
        }

        if (FlxG.save.data.autoTap == true){
            autoTap(true);
        }
        else {
            autoTap(false);
        }

        if (devThing){
            // #if sys
            // if (Sys.args().contains('dev mode')){
            //     FlxG.save.data.coin += 9999;
            // }
            // #else
            // trace('you do not have dev mode enabled');
            // #end
            #if macro
            if (@:privateAccess Macros.getDefine('dev mode')){//I'm too lazy
                FlxG.save.data.coin += 9999;
                trace('dev mode enable');
            }
            else {
                trace('you do not have dev mode enabled');
            }
            #else
            trace('platform does not support dev mode');
            #end
        }

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
            checkText.text = "";
		} else {
            // trace("Controller detected!, read controller.txt file");
            checkText.text = "Controller detected!";
			getControls(gamepad);
		}
    }

    inline function autoTap(enabled:Bool = false):Bool
    {
        //loop forever
        return enabled;
    }

    public static function getControls(gamepad:FlxGamepad) {
        if (gamepad.justPressed.X 
            || gamepad.justPressed.Y 
            || gamepad.justPressed.A 
            || gamepad.justPressed.B 
            || gamepad.justPressed.LEFT_STICK_CLICK 
            || gamepad.justPressed.RIGHT_STICK_CLICK
        ){
            sprite.animation.play('tap');

            if (FlxG.save.data.x2 == true)
                FlxG.save.data.coin += 2;
            else
                FlxG.save.data.coin++;

            FlxG.save.flush();
        }

        if (gamepad.justPressed.START){
            trace('wellcome');

            FlxG.switchState(new StoreState());

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }

            FlxG.save.flush();

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }
        }

        if (gamepad.justPressed.RIGHT_TRIGGER){
            FlxG.switchState(new OptionsState());

            FlxG.save.flush();
        }
	}
}