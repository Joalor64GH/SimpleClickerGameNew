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
    var coinTxt:FlxText;

    override function create()
    {
        super.create();

        item_display();
        body_someone();

        if (FlxG.sound.music == null) // don't restart the music if it's already playing
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
        }
			
		if (FlxG.keys.justPressed.DOWN){
            select += 1;
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
                    }else if (FlxG.save.data.coin > 200){
                        FlxG.save.data.coin -= 200;
                        FlxG.save.data.x2++;
                    }else if (FlxG.save.data.x2 == 1){
                        FlxG.save.data.coin -= 0;
                        FlxG.save.data.x2++;
                    }

                case "Auto Tap":
                    // unfinsished

                case "Back":
                    FlxG.save.flush();
                    FlxG.switchState(new PlayState());
            }
        }
    }

    override function destory(){
        super.destroy();

        if (FlxG.sound.music != null){
            FlxG.sound.music.stop();
        }
    }
}