package fps;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.*;
import flixel.input.gamepad.FlxGamepad;
import lime.app.Application;

class FPSCAP extends FlxState
{
    var text:FlxText;

    override function create()
    {
        super.create();

        text = new FlxText(0, 0, 0, "FPS: " + FlxG.save.data.fps, 24);
        text.screenCenter();
        add(text);
    }

    override function update(elapsed:Float)
    {
        text.text = "FPS: " + FlxG.save.data.fps;

        FlxG.updateFramerate = FlxG.save.data.fps;
        FlxG.drawFramerate = FlxG.save.data.fps;

        var lf = FlxG.keys.justPressed.LEFT;
        var rt = FlxG.keys.justReleased.RIGHT;
        var back = FlxG.keys.justPressed.ESCAPE;

        if (lf){
            if (FlxG.save.data.fps == 60){
                FlxG.save.data.fps -= 0;
            }else{
                FlxG.save.data.fps -= 10;
            }

            FlxG.updateFramerate = FlxG.save.data.fps;
            FlxG.drawFramerate = FlxG.save.data.fps;

            FlxG.save.flush();
        }

        if (rt){
            if (FlxG.save.data.fps == 240){
                FlxG.save.data.fps += 0;
            }else{
                FlxG.save.data.fps += 10;
            }

            FlxG.updateFramerate = FlxG.save.data.fps;
            FlxG.drawFramerate = FlxG.save.data.fps;

            FlxG.save.flush();
        }

        if (back){
            FlxG.switchState(new OptionsState.QualityState());
            FlxG.save.flush();

            FlxG.updateFramerate = FlxG.save.data.fps;
            FlxG.drawFramerate = FlxG.save.data.fps;
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
        if (gamepad.justPressed.DPAD_LEFT){
            if (FlxG.save.data.fps == 60){
                FlxG.save.data.fps -= 0;
            }else{
                FlxG.save.data.fps -= 10;
            }

            FlxG.updateFramerate = FlxG.save.data.fps;
            FlxG.drawFramerate = FlxG.save.data.fps;
        }

        if (gamepad.justPressed.DPAD_RIGHT){
            if (FlxG.save.data.fps == 240){
                FlxG.save.data.fps += 0;
            }else{
                FlxG.save.data.fps += 10;
            }

            FlxG.updateFramerate = FlxG.save.data.fps;
            FlxG.drawFramerate = FlxG.save.data.fps;
        }

        if (gamepad.justPressed.BACK){
            FlxG.switchState(new OptionsState.QualityState());
            FlxG.save.flush();

            FlxG.updateFramerate = FlxG.save.data.fps;
            FlxG.drawFramerate = FlxG.save.data.fps;
        }    
	}
}