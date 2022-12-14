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

        coinTxt = new FlxText(5, FlxG.height - 18, 0, "Coin: " + FlxG.save.data.coin, 16);
        add(coinTxt);

        sprite = new Sprite_Game(0, 0, "button");
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

        if (store)
        {
            FlxG.switchState(new StoreState());

            FlxG.save.flush();
        }

        if (press)
        {
            sprite.animation.play('tap');

            if (FlxG.save.data.x2 == 1)
                FlxG.save.data.coin += 2;
            else
                FlxG.save.data.coin++;
            
            FlxG.save.flush();
        }

        if (press_alt)
        {
            sprite.animation.play('tap');

            if (FlxG.save.data.x2 == 1)
                FlxG.save.data.coin += 2;
            else
                FlxG.save.data.coin++;
            
            FlxG.save.flush();
        }

        if (FlxG.save.data.autoTap == 1){
            autoTap();
        }  
    }

    function autoTap()
    {
        //loop forever
    }
}