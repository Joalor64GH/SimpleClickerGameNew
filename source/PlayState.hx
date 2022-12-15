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

        if (FlxG.sound.music == null) // don't restart the music if it's already playing
        {
            // idk should we add more then one song??
            FlxG.sound.playMusic(Paths.music('buttonClicker'), 1, true);
        }
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

        if (press || autoTap())
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

    inline function autoTap():Bool
    {
        //loop forever
        return true;
    }

    override function destory(){
        super.destroy();

        if (FlxG.sound.music != null){
            FlxG.sound.music.stop();
        }
    }
}