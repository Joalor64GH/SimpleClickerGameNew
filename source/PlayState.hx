package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
    var sprite:Sprite_Game;
    var sprite_tween:FlxTween;
    // var coin:Int = 0;
    var coinTxt:FlxText;

    override public function create()
    {
        super.create();

        SystemData.coin(); //when first playing, number of coin are null
        SystemData.saveData();

        var text = new FlxText(0, 0, 0, "Simple Clicker Game", 32);
        text.screenCenter(X);
        add(text);

        coinTxt = new FlxText(5, FlxG.height - 18, 0, "Coin: " + FlxG.save.data.coin +
        if (FlxG.save.data.autoTap) 
            " | Auto Tap is Enable";
        else
            "", 16);
        add(coinTxt);

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
        if (FlxG.save.data.autoTap == 1) 
            " | Auto Tap is Enable";
        else
            "";

        var options = FlxG.keys.justPressed.Q;
        var press = FlxG.keys.justPressed.ENTER;
        var press_alt = FlxG.keys.justPressed.SPACE;
        var store = FlxG.keys.justPressed.S;
        var reset = FlxG.keys.justPressed.R;
        var devThing = FlxG.keys.justPressed.L;

        // if (options)
        // {
        //     FlxG.switchState(new OptionsState());
        // }

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

            if (FlxG.save.data.x2 == 1)
                FlxG.save.data.coin += 2;
            else
                FlxG.save.data.coin++;

            FlxG.save.flush();
        }

        if (reset){
            FlxG.save.data.coin = 0;
            FlxG.save.data.autoTap = 0;
            FlxG.save.data.x2 = 0;

            FlxG.sound.play(Paths.sound('resetSound'), 1);
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
            }
            else {
                trace('you do not have dev mode enabled');
            }
            #else
            trace('platform does not support dev mode');
            #end
        }

        if (FlxG.save.data.autoTap == 1){
            autoTap(true);
        }
        else {
            autoTap(false);
        }
    }

    inline function autoTap(enabled:Bool = false):Bool
    {
        //loop forever
        return enabled;
    }
}