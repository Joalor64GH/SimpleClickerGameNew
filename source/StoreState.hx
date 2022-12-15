package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.text.FlxText;

using StringTools;

class StoreState extends FlxState
{
    var item:Array<String> = [
        'X2', 'Auto Tap'
        , 'Back'
    ];

    var grpitem:FlxTypedGroup<FlxText>;
    var select:Int = 0;
    var human:Sprite_Game;
    var details:Sprite_Game;
    var coinTxt:FlxText;
    var coin_details:Sprite_Game;

    override function create()
    {
        super.create();

        item_display();
        body_someone();
    }

    inline function body_someone()
    {
        human = new Sprite_Game(300, 0, 'shop');
        human.screenCenter(Y);
        add(human);
    }

    inline function item_display()
    {
        details = new Sprite_Game(31.7, 539.35, 'details_store');
        add(details);

        coin_details = new Sprite_Game(29.9, 519.8, 'coin_store');
        coin_details.visible = true;
        coin_details.color = 0xCCCCCC;
        add(coin_details);

        coinTxt = new FlxText(5, FlxG.height - 18, 0, "Coin: " + FlxG.save.data.coin, 16);
        add(coinTxt);

		grpitem = new FlxTypedGroup<FlxText>();
		add(grpitem);

        for (i in 0...item.length)
        {
            var optionText:FlxText = new FlxText(20, 100 + (i * 50), 0, item[i], 32);
            // optionText.screenCenter(Y);
            optionText.ID = i;
            grpitem.add(optionText);
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        coinTxt.text = "Coin: " + FlxG.save.data.coin;
        
        grpitem.forEach(function(txt:FlxText)
        {
            txt.color = FlxColor.WHITE;
    
            if (txt.ID == select)
                txt.color = FlxColor.YELLOW;
        });
        controls();
    }

    function controls()
    {
        if (FlxG.keys.justPressed.UP){
            select -= 1;
            switch(item[select])
            {
                case "X2":
                    details.animation.play("select_1");
                    coin_details.visible = true;
                    coin_details.animation.play("coin 200");
                
                case "Auto Tap":
                    details.animation.play("select_2");
                    coin_details.visible = true;
                    coin_details.animation.play("coin 400");

                case "Back":
                    details.animation.play("select_3");
                    coin_details.visible = false;
                    coin_details.animation.play("blanks");
            }
        }
			
		if (FlxG.keys.justPressed.DOWN){
            select += 1;
            switch(item[select])
            {
                case "X2":
                    details.animation.play("select_1");
                    coin_details.visible = true;
                    coin_details.animation.play("coin 200");
                
                case "Auto Tap":
                    details.animation.play("select_2");
                    coin_details.visible = true;
                    coin_details.animation.play("coin 400");

                case "Back":
                    details.animation.play("select_3");
                    coin_details.visible = false;
                    coin_details.animation.play("blanks");
            }
        }
			
		if (select < 0)
			select = grpitem.length - 1;

		if (select >= grpitem.length)
			select = 0;

        if (FlxG.keys.justPressed.ENTER)
        {
            switch(item[select])
            {
                case "X2":
                    if (FlxG.save.data.coin < 200){
                        trace('not have much money we want');
                    }else if (FlxG.save.data.coin < 200){
                        FlxG.save.data.coin -= 200;
                        FlxG.save.data.x2++;
                        buy_animation();
                    }else if (FlxG.save.data.x2 == 1){
                        trace('x2 active!');
                        FlxG.save.data.coin -= 0;
                        FlxG.save.data.x2++;
                    }

                case "Auto Tap":


                case "Back":
                    FlxG.save.flush();
                    FlxG.switchState(new PlayState());
            }
        }
    }
}