package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;
import lime.app.Application;

class OptionsState extends FlxState {
    public final optionsCategorys:Array<String> = [
        'Controls',
        'Quality',
        'Credits',
        'Back'
    ];

    public var optionsText:FlxText;

    public var selectedOption:Int = 0;

    public var textGroup:FlxTypedGroup<FlxText>;

    var checkText:FlxText;

    override function create(){
        textGroup = new FlxTypedGroup<FlxText>();

        for (i in 0...optionsCategorys.length){
            optionsText = new FlxText(0, 300 + (i * 50), 0, optionsCategorys[i], 32);
            optionsText.screenCenter(X);
            optionsText.ID = i;
            add(optionsText);
            textGroup.add(optionsText);
        }

        checkText = new FlxText(5, FlxG.height - 36, 0, "", 16);
        add(checkText);

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

        if (FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new PlayState());
            FlxG.save.flush();
        }

        if (FlxG.keys.justPressed.ENTER)
        {
            switch(optionsCategorys[selectedOption])
            {
                case "Quality":
                    FlxG.switchState(new QualityState());
                    FlxG.save.flush();                   
                case "Back":
                    FlxG.switchState(new PlayState());
                    FlxG.save.flush();

                case "Credits":
                    FlxG.switchState(new credits.CreditsState());
            }
        }

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
            // checkText.text = "";
            Application.current.window.title = "Simple Clicker Game";
		} else {
            // trace("Controller detected!, read controller.txt file");
            // checkText.text = "Controller detected!";
			Application.current.window.title = "Simple Clicker Game - Controller detected!";
            getControls(gamepad);
		}

        super.update(elapsed);
    }

    public function getControls(gamepad:FlxGamepad) {
        if (gamepad.justPressed.A){
            // unfinished
            switch(optionsCategorys[selectedOption])
            {
                case "Quality":
                    FlxG.switchState(new QualityState());
                    FlxG.save.flush();                       
                case "Back":
                    FlxG.switchState(new PlayState());
                    FlxG.save.flush();

                case "Credits":
                    FlxG.switchState(new credits.CreditsState());    
            }
        }

        if (gamepad.justPressed.DPAD_DOWN){
            changeOption(1);
        }

        if (gamepad.justPressed.DPAD_UP){
            changeOption(-1);
        }

        if (gamepad.justPressed.BACK){
            FlxG.switchState(new PlayState());
            FlxG.save.flush();
        }    
	}
}

class QualityState extends FlxState {
    public final optionsCategorys:Array<String> = [
        'Low Quality',
        'Shit Quality',
        'FPS Cap',
        'Hide Coin Details',
        'Back'
    ];

    public var optionsText:FlxText;

    public var selectedOption:Int = 0;

    public var textGroup:FlxTypedGroup<FlxText>;

    var checkText:FlxText;

    override function create(){
        textGroup = new FlxTypedGroup<FlxText>();

        for (i in 0...optionsCategorys.length){
            optionsText = new FlxText(0, 300 + (i * 50), 0, optionsCategorys[i], 32);
            optionsText.screenCenter(X);
            optionsText.ID = i;
            add(optionsText);
            textGroup.add(optionsText);
        }

        checkText = new FlxText(5, FlxG.height - 36, 0, "", 16);
        add(checkText);

        super.create();

        changeOption(0);
    }

    private function changeOption(option:Int):Void{
        selectedOption += option;

        if (selectedOption >= optionsCategorys.length){
            selectedOption = 0;
        }
        if (selectedOption < 0){
            selectedOption = 0;
        }

        switch(optionsCategorys[selectedOption]){
            case "Low Quality":
                checkText.text = FlxG.save.data.lowQuality ? "ENABLED" : "DISABLED";

            case "Shit Quality":
                checkText.text = FlxG.save.data.shitQuality ? "ENABLED" : "DISABLED";

            case "FPS Cap":
                checkText.text = "";

            case "Hide Coin Details":
                checkText.text = FlxG.save.data.hideCoin ? "ENABLED" /*"YES"*/ : "DISABLED" /*"NO"*/;

            case "Back":
                checkText.text = "";
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

        if (FlxG.keys.justPressed.ESCAPE){
            FlxG.switchState(new OptionsState());
            FlxG.save.flush();
        }

        if (FlxG.keys.justPressed.ENTER)
        {
            switch(optionsCategorys[selectedOption])
            {
                case "Low Quality":
                    FlxG.save.data.lowQuality = !FlxG.save.data.lowQuality;
			    checkText.text = FlxG.save.data.lowQuality ? "ENABLED" : "DISABLED";

                case "Shit Quality":
                    FlxG.save.data.shitQuality = !FlxG.save.data.shitQuality;
			    checkText.text = FlxG.save.data.shitQuality ? "ENABLED" : "DISABLED";

                case "Hide Coin Details":
                    FlxG.save.data.hideCoin = !FlxG.save.data.hideCoin;
			    checkText.text = FlxG.save.data.hideCoin ? "ENABLED" /*"YES"*/ : "DISABLED" /*"NO"*/;

                case "FPS Cap":
                    FlxG.switchState(new fps.FPSCAP());

                case "Back":
                    FlxG.switchState(new OptionsState());
                    FlxG.save.flush();
            }
        }

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
            // checkText.text = "";
            Application.current.window.title = "Simple Clicker Game";
		} else {
            // trace("Controller detected!, read controller.txt file");
            // checkText.text = "Controller detected!";
			Application.current.window.title = "Simple Clicker Game - Controller detected!";
            getControls(gamepad);
		}

        super.update(elapsed);
    }

    public function getControls(gamepad:FlxGamepad) {
        if (gamepad.justPressed.A){
            // unfinished
            switch(optionsCategorys[selectedOption])
            {
                case "Low Quality":
			    FlxG.save.data.lowQuality = !FlxG.save.data.lowQuality;
			    checkText.text = FlxG.save.data.lowQuality ? "ENABLED" : "DISABLED";

                case "Shit Quality":
			    FlxG.save.data.shitQuality = !FlxG.save.data.shitQuality;
			    checkText.text = FlxG.save.data.shitQuality ? "ENABLED" : "DISABLED";

                case "Hide Coin Details":
			    FlxG.save.data.hideCoin = !FlxG.save.data.hideCoin;
			    checkText.text = FlxG.save.data.hideCoin ? "ENABLED" /*"YES"*/ : "DISABLED" /*"NO"*/;

                case "Back":
                    FlxG.switchState(new OptionsState());
                    FlxG.save.flush();
            }
        }

        if (gamepad.justPressed.DPAD_DOWN){
            changeOption(1);
        }

        if (gamepad.justPressed.DPAD_UP){
            changeOption(-1);
        }

        if (gamepad.justPressed.BACK){
            FlxG.switchState(new OptionsState());
            FlxG.save.flush();
        }    
	}
}
