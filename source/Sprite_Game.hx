package;

import flixel.FlxSprite;

/**
    Custom FlxSprite File, yeah!

    Super Easy

    Float Time

    :skull:
**/

class Sprite_Game extends FlxSprite
{

    var non_idle:Bool = false;

    /**
        * Enter your x postion
    **/
    public var x_pos:Float;

    /**
        * Enter your y postion
    **/
    public var y_pos:Float;

    /**
        * Enter your sprite name
    **/
    public var sprite:String = 'button';

    public function new(x_pos:Float, y_pos:Float, ?sprite:String = "button"):Void
    {
        super(x_pos, y_pos);

        switch(sprite)
        {
            case "button":
                frames = Paths.getSparrowAtlas('sprite');
                animation.addByPrefix('idle', 'normal', 1, false);
                animation.addByPrefix('tap', 'press', 6, false);
                antialiasing = true;
                non_idle = false;

            case "shop":
                frames = Paths.getSparrowAtlas('shop');
                animation.addByPrefix('idle', 'shop_human', 16, true);
                antialiasing = true;
                non_idle = false;

            case "details_store":
                frames = Paths.getSparrowAtlas('store_details');
                animation.addByPrefix('select_1', 'select_1', 16, false);
                animation.addByPrefix('select_2', 'select_2', 16, false);
                animation.addByPrefix('select_3', 'select_3', 16, false);
                antialiasing = true;
                non_idle = true;

            case "coin_store":
                frames = Paths.getSparrowAtlas('store_coin');
                animation.addByPrefix('blanks', 'blanks', 16, false);
                animation.addByPrefix('coin 200', 'coin_200', 16, false);
                animation.addByPrefix('coin 400', 'coin_400', 16, false);
                animation.addByPrefix('buy!', 'coin_buy!',10, false);
                animation.addByPrefix('dont_much_money!', 'dont_have_much_money', 16, false);
                antialiasing = true;
                non_idle = true;
        }
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // playAnimation('idle');
        // animation.play('idle');
        animation.play('idle');
        // }
    }
}