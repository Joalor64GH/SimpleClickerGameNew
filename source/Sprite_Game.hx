package;

import flixel.FlxSprite;

class Sprite_Game extends FlxSprite
{
    public var sprite:String = 'button';

    public function new(x:Float, y:Float, ?sprite:String = "button"):Void
    {
        super(x, y);

        switch(sprite)
        {
            case "button":
                frames = Paths.getSparrowAtlas('sprite');
                animation.addByPrefix('idle', 'normal', 1, false);
                animation.addByPrefix('tap', 'press', 6, false);

            case "shop":
                frames = Paths.getSparrowAtlas('shop');
                animation.addByPrefix('idle', 'shop_human', 16, true);

                antialiasing = true;

        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // playAnimation('idle');
        animation.play('idle');
    }
}