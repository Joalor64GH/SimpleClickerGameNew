package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class OptionsState extends FlxState {
    public var optionsCategorys:Array<String> = ['Gameplay', 'Visuals', 'Audio', 'Misc', 'Back'];

    public var optionsText:FlxText;

    public var selectedOption:Int = 0;

    override function create(){
        for (i in optionsCategorys.length){
            optionsText = new FlxText(0, 100, 0, optionsCategorys[i], 32);
            optionsText.screenCenter(X);
            add(optionsText);
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
        if (optionsCategorys.length = selectedOption){
            optionsText.color = flixel.util.FlxColor.GREEN;
        }
        else {
            optionsText.color = flixel.util.FlxColor.WHITE;
        }

        super.update(elapsed);
    }
}