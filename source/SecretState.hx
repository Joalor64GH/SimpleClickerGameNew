package;

import flixel.util.FlxColor;
import flixel.addons.ui.FlxInputText;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class SecretState extends FlxState
{
    var type_text:FlxInputText;
    override function create() 
    {
        type_text = new FlxInputText(0, 0, 150, "", 16, FlxColor.WHITE);
        type_text.maxLength = 20;
        type_text.screenCenter();
        add(type_text);

        super.create();    
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        var wrong:Bool = false;

        if (type_text.text != "" && FlxG.keys.justPressed.ENTER)
        {
            switch(type_text.text)
            {
                case "SCG":
                    FlxG.save.data.coin += 200;
                    wrong = false;
                
                case "LikeSCG":
                    FlxG.save.data.coin += 500;
                    wrong = false;

                case "Enter":
                    FlxG.save.data.coin += 50;
                    wrong = false;
                    
                case "Windows":
                    FlxG.save.data.coin += 80;
                    FlxG.save.data.x2 = true;
                    wrong = false;

                default: 
                    wrong = true;    
            }
        }

        if (wrong == true)
        {
            type_text.text = "";
            wrong = false;
        }

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.save.flush();
            FlxG.switchState(new PlayState());
        }
    }    
}