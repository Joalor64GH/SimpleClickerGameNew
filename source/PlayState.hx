package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
    var sprite:Sprite_Game;
    // var coin:Int = 0;
    var coinTxt:FlxText;

    override public function create()
    {
        super.create();

        // var text = new FlxText(0, 0, 0, "Simple Clicker Game", 64);
        // text.screenCenter(X);
        // add(text);

        coinTxt = new FlxText(0, 0, 0, "Coin: " + FlxG.save.data.coin, 16);
        add(coinTxt);

        sprite = new Sprite_Game(0, 0);
        sprite.screenCenter();
        add(sprite);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        coinTxt.text = "Coin: " + FlxG.save.data.coin;

        var options = FlxG.keys.justPressed.Q;
        var press = FlxG.keys.justPressed.ENTER;
        var press_alt = FlxG.keys.justPressed.SPACE;
        var store = FlxG.keys.justPressed.S;

        // if (options)
        // {
        //     FlxG.switchState(new OptionsState());
        // }

        if (press)
        {
            FlxG.save.data.coin++;
            FlxG.save.flush();
        }

        if (press_alt)
        {
            FlxG.save.data.coin++;
            FlxG.save.flush();
        }
    }
}