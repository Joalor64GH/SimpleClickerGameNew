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
        * for shop
        
        * to playing thank animation
    **/
    public static var thank_buy:Bool = true;

    /**
        * for shop

        * to playing dont much money animation
    **/
    public static var dont_much_coin:Bool = true;

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

    public function new(x_pos:Float, y_pos:Float, ?sprite:String = "button", ?thank_buy:Bool = true, ?dont_much_coin:Bool = true):Void
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
                animation.addByPrefix('idle', 'shop_human0', 16, true);
                animation.addByPrefix('talk', 'shop_human_talk0', 14, false);
                thank_buy = true;
                animation.addByPrefix('thank_for_buy', 'shop_human_buy0', 14, false);
                dont_much_coin = true;
                animation.addByPrefix('dont_much_money_i_want', 'shop_human_not_much_money_i_want0', 14, false);
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

        playAnimation('idle');
    }

    inline public function playAnimation(name:String, ?forced:Bool, ?reverse:Bool, ?frame:Int):Void{
        animation.play(name, forced, reverse, frame);
    }
}