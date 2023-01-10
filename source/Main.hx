package;

import flixel.FlxG;
import openfl.display.FPS;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	var gameWidth:Int = 800; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 600; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions. (Removed from Flixel 5.0.0)
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets'

	public static inline final curVersion:String = '0.1.0';

	// You can pretty much ignore everything from here on - your code should go in your states.
	
	public function new()
	{
		// FlxG.updateFramerate = FlxG.save.data.fps;
		// FlxG.drawFramerate = FlxG.save.data.fps;
		
		super();
		addChild(new FlxGame(
			gameWidth, 
			gameHeight, 
			PlayState, 
			#if (flixel < "5.0.0") zoom, #end 
			framerate, 
			framerate, 
			skipSplash, 
			startFullscreen
		));
		addChild(new FPS(10, 3, 0xFFFFFF));

		FlxG.mouse.unload();
		FlxG.mouse.load(Paths.image('cursor'), 1.5, 0, 0);
	}
}
