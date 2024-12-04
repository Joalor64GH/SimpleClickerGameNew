package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

#if desktop
import ALSoftConfig;
#end

#if sys
import sys.io.File;
import sys.FileSystem;
#end

class Main extends Sprite
{
	var gameWidth:Int = 800; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 600; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets'

	public static inline final curVersion:String = '0.1.0';
	
	public function new()
	{
		// FlxG.updateFramerate = FlxG.save.data.fps;
		// FlxG.drawFramerate = FlxG.save.data.fps;
		
		super();

		#if FUTURE_POLYMOD
		if (!FileSystem.exists('./mods/'))
			FileSystem.createDirectory('.mods/');
		if (!FileSystem.exists('mods/mods-go-here.txt'))
			File.saveContent('mods/mods-go-here.txt', '');
		#end

		addChild(new FlxGame(
			gameWidth, 
			gameHeight, 
			PlayState, 
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
