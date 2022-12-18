package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;

class OptionsState extends FlxState {
    public final optionsCategorys:Array<String> = ['Gameplay', 'Visuals', 'Audio', 'Misc', 'Back'];

    public var optionsText:FlxText;

    public var selectedOption:Int = 0;

    public var textGroup:FlxTypedGroup<FlxText>;

    override function create(){
        textGroup = new FlxTypedGroup<FlxText>();

        for (i in 0...optionsCategorys.length){
            optionsText = new FlxText(0, 400 + (i * 50), 0, optionsCategorys[i], 32);
            optionsText.screenCenter(X);
            optionsText.ID = i;
            add(optionsText);
            textGroup.add(optionsText);
        }

        super.create();
    }

    private function changeOption(option:Int):Void{
        selectedOption += option;

        if (selectedOption >= optionsCategorys.length){
            selectedOption = 0;
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

        if (FlxG.keys.justPressed.S || FlxG.keys.justPressed.DOWN){
            changeOption(1);
        }
        if (FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP){
            changeOption(-1);
        }

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
        } else {
            // trace("Controller detected!, read controller.txt file");
            getControls(gamepad);
        }

        super.update(elapsed);
    }

    public function getControls(gamepad:FlxGamepad) {
        if (gamepad.justPressed.A){
            // unfinished
        }

        if (gamepad.justPressed.DPAD_DOWN){
            changeOption(1);
        }

        if (gamepad.justPressed.DPAD_UP){
            changeOption(-1);
        }

        if (gamepad.justPressed.BACK){

        }    
	}
}