package;

import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.text.FlxText;

using StringTools;

class StoreState extends FlxState
{
    public static var item:Array<String> = [
        'X2', 'Auto Tap'
        , 'Back'
    ];

    public static var have_gamePad:Bool = false;

    public static var grpitem:FlxTypedGroup<FlxText>;
    public static var select:Int = 0;
    public static var human:Sprite_Game;
    public static var details:Sprite_Game;
    public static var coinTxt:FlxText;
    public static var coin_details:Sprite_Game;

    static var checkText:FlxText;

    override function create()
    {
        super.create();

        item_display();
        body_someone();

        open_store();
        if (FlxG.sound.music == null || !FlxG.sound.music.playing) // don't restart the music if it's already playing
        {
            // idk should we add more then one song??
            FlxG.sound.playMusic(Paths.music('shopMusic'), 1, true);
        }
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

        checkText = new FlxText(5, FlxG.height - 36, 0, "", 16);
        add(checkText);

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
        // talk_npc();
    }

    /*function talk_npc()
    {
        if (FlxG.mouse.overlaps(human) && FlxG.mouse.justPressed)
        {
            human.animation.play('talk');
        }
    }*/

    public static function controls()
    {
        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
            checkText.text = "";
            have_gamePad = false;
		} else {
            // trace("Controller detected!, read controller.txt file");
            checkText.text = "Controller detected!";
			// getControls(gamepad);
            have_gamePad = true;
		}

        if (have_gamePad == true && gamepad.justPressed.B){
            FlxG.save.flush();
            FlxG.switchState(new PlayState());

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }
        }

        if (FlxG.keys.justPressed.UP || have_gamePad == true && gamepad.justPressed.DPAD_UP || have_gamePad == true && gamepad.justPressed.LEFT_STICK_DIGITAL_DOWN){
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
			
		if (FlxG.keys.justPressed.DOWN || have_gamePad == true && gamepad.justPressed.DPAD_DOWN || have_gamePad == true && gamepad.justPressed.LEFT_STICK_DIGITAL_UP){
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

        if (FlxG.keys.justPressed.ENTER || have_gamePad == true && gamepad.justPressed.X || have_gamePad == true && gamepad.justPressed.LEFT_STICK_CLICK)
        {
            switch(item[select])
            {
                case "X2":
                    if (FlxG.save.data.coin < 200 || SystemData.ownItem == false)
                    {
                        trace('not have much money we want');
                        SystemData.ownItem == false;
                        didnt_have_much_money();
                    }
                    else if (FlxG.save.data.coin < 200 || SystemData.ownItem == false)
                    {
                        trace('not have much money we want');
                        SystemData.ownItem == false;
                        didnt_have_much_money();
                    }else if (FlxG.save.data.coin == 200 || SystemData.ownItem == false)
                    {
                        trace('x2 active!');
                        FlxG.save.data.coin -= 200;
                        FlxG.save.data.x2 = true;
                        SystemData.ownItem == true;
                        buy_animation();
                    }
                    else if (SystemData.ownItem == true) //when you already buy that item
                    {
                        if (FlxG.save.data.x2 == true){
                            trace('x2 Unactive!');
                            FlxG.save.data.coin -= 0;
                            FlxG.save.data.x2 = false;
                            SystemData.ownItem == true;
                        }else if (FlxG.save.data.x2 == false) {
                            trace('x2 active!');
                            FlxG.save.data.coin -= 0;
                            FlxG.save.data.x2 = true;
                            SystemData.ownItem == true;
                        }
                    }

                case "Auto Tap":
                    // unfinsished, tested
                    if (FlxG.save.data.coin < 400){
                        trace('not have much money we want');
                        didnt_have_much_money();
                    }else if (FlxG.save.data.coin == 400){
                        trace('x2 active!');
                        FlxG.save.data.coin -= 400;
                        FlxG.save.data.autoTap++;
                        buy_animation();
                    }else if (FlxG.save.data.x2 == 1){
                        trace('x2 active!');
                        FlxG.save.data.coin -= 0;
                        FlxG.save.data.autoTap++;
                    }

                case "Back":
                    FlxG.save.flush();
                    FlxG.switchState(new PlayState());

                    if (FlxG.sound.music != null){
                        FlxG.sound.music.stop();
                    }
            }
        }
    }

    public static function open_store()
    {
        switch(item[select])
        {
            case "X2":
                if (coin_details.animation.getByName('buy!') != null){
                    coin_details.animation.play("coin 200");
                    coin_details.visible = true;
                    coin_details.color = 0xCCCCCC;
                }

            case "Auto Tap":
                if (coin_details.animation.getByName('buy!') != null){
                    coin_details.animation.play("coin 400");
                    coin_details.visible = true;
                    coin_details.color = 0xCCCCCC;
                }

            case "Back":
                if (coin_details.animation.getByName('buy!') != null){
                    coin_details.animation.play("blanks");
                    coin_details.visible = false;
                    coin_details.color = 0xCCCCCC;
                }
        }        
    }

    public static function buy_animation() 
    {
        coin_details.animation.play("buy!");
        coin_details.color = 0x09FF00;

        human.animation.play('thank_for_buy');
        
        new FlxTimer().start(1, function(tmr:FlxTimer) {
            switch(item[select])
            {
                case "X2":
                    if (coin_details.animation.getByName('buy!') != null){
                        coin_details.animation.play("coin 200");
                        coin_details.visible = true;
                        coin_details.color = 0xCCCCCC;
                        human.animation.play('idle'); 
                    }

                case "Auto Tap":
                    if (coin_details.animation.getByName('buy!') != null){
                        coin_details.animation.play("coin 400");
                        coin_details.visible = true;
                        coin_details.color = 0xCCCCCC;
                        human.animation.play('idle'); 
                    }

                case "Back":
                    if (coin_details.animation.getByName('buy!') != null){
                        coin_details.animation.play("blanks");
                        coin_details.visible = false;
                        coin_details.color = 0xCCCCCC;
                        human.animation.play('idle'); 
                    }
            }
        });
    }

    public static function didnt_have_much_money()
    {
        coin_details.animation.play("dont_much_money!");
        coin_details.color = 0xBB0000;

        human.animation.play('dont_much_money_i_want');
        
        new FlxTimer().start(1, function(tmr:FlxTimer) {
            switch(item[select])
            {
                case "X2":
                    if (coin_details.animation.getByName('dont_much_money!') != null){
                        coin_details.animation.play("coin 200");
                        coin_details.visible = true;
                        coin_details.color = 0xCCCCCC;
                        human.animation.play('idle'); 
                    }

                case "Auto Tap":
                    if (coin_details.animation.getByName('dont_much_money!') != null){
                        coin_details.animation.play("coin 400");
                        coin_details.visible = true;
                        coin_details.color = 0xCCCCCC;
                        human.animation.play('idle'); 
                    }

                case "Back":
                    if (coin_details.animation.getByName('dont_much_money!') != null){
                        coin_details.animation.play("blanks");
                        coin_details.visible = false;
                        coin_details.color = 0xCCCCCC;
                        human.animation.play('idle'); 
                    }
            }
        }); 
    }
}