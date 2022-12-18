package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;

class OptionsState extends FlxState {
    public final optionsCategorys:Array<String> = ['Gameplay', 'Visuals', 'Audio', 'Misc', 'Back'];

    public var optionsText:FlxText;

    public var selectedOption:Int = 0;

    public var textGroup:FlxTypedGroup<FlxText>;

    override function create(){
        textGroup = new FlxTypedGroup<FlxText>();

        for (i in 0...optionsCategorys.length){
            optionsText = new FlxText(0, 100, 0, optionsCategorys[i], 32);
            optionsText.screenCenter(X);
            add(optionsText);
            textGroup.add(optionsText);
        }

        if (FlxG.keys.justPressed.S || FlxG.keys.justPressed.DOWN){
            changeOption(1);
        }
        else if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP){
            changeOption(-1);
        }

        super.create();
    }

    private function changeOption(option:Int):Void{
        selectedOption += option;

        if (selectedOption > optionsCategorys.length){
            selectedOption = 5;
        }
        if (selectedOption < 0){
            selectedOption = 0;
        }
    }

    override function update(elapsed:Float){
		textGroup.forEach(function(txt:FlxText)
        {
            txt.color = FlxColor.WHITE;
    
            if (txt.ID == selectedOption)
                txt.color = FlxColor.YELLOW;
        });

        super.update(elapsed);
    }
}