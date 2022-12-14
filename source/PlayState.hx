package;

import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class PlayState extends FlxState
{
    var sprite:Sprite_Game;

    override public function create()
    {
        super.create();

        var text = new flixel.text.FlxText(0, 0, 0, "Simple Clicker Game", 64);
        text.screenCenter(X);
        add(text);

        sprite = new Sprite_Game(0, 0);
        add(sprite);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}