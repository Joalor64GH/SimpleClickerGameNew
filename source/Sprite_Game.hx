package;

import flixel.FlxSprite;

class Sprite_Game extends FlxSprite
{
    public function new(x:Float, y:Float):Void
    {
        super(x, y);

        frames = Paths.getSparrowAtlas('sprite');
        animation.addByPrefix('idle', 'normal', 24, false);
        animation.addByPrefix('tap', 'press', 24, false);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // playAnimation('idle');
        animation.play('idle');
    }
}