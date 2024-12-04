package;

import SecretState;
import lime.app.Application;
import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxColor;
import flixel.system.FlxAssets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.*;
import flixel.ui.*;
import flixel.input.mouse.FlxMouse;
import flixel.util.FlxTimer;
import HscriptTool;

class PlayState extends FlxState
{
    public static var gamepad:FlxGamepad;

    public static var sprite:Sprite_Game;
    public static var sprite_tween:FlxTween;
    public static var coinTxt:FlxText;

    public var scriptArray:Array<HscriptTool> = [];

    var checkText:FlxText;
    var bg:FlxSprite;

    override public function create()
    {
        super.create();

        ModHandler.reload();

        bg = new FlxSprite();
        bg.makeGraphic(800, 600, FlxColor.CYAN);
        bg.screenCenter();
        add(bg);

        var foldersToCheck:Array<String> = [Paths.file('data/')];
		#if FUTURE_POLYMOD
		for (mod in ModHandler.getModIDs())
			foldersToCheck.push('mods/' + mod + '/data/');
		#end
		for (folder in foldersToCheck) {
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder)) {
				for (file in FileSystem.readDirectory(folder)) {
					if (file.endsWith('.hx')) {
						scriptArray.push(new HscriptTool(folder + file));
					}
				}
			}
		}

        for (script in scriptArray) {
			script?.setVariable('addScript', function(path:String) {
				scriptArray.push(new HscriptTool('$path.hx'));
			});
		}

        SystemData.coin(); //when first playing, number of coin are null
        SystemData.saveData();
        
        var text = new FlxText(0, 0, 0, "Simple Clicker Game", 32);
        text.screenCenter(X);
        add(text);

        coinTxt = new FlxText(5, FlxG.height - 18, 0, 
            "Coin: " + FlxG.save.data.coin +
            if (FlxG.save.data.autoTap == true)
                " | Auto Tap is Enable";
            else if (FlxG.save.data.autoTap == false)
                "";
            else
                "", 16);
        add(coinTxt);

        checkText = new FlxText(5, FlxG.height - 36, 0, "", 16);
        add(checkText);

        sprite = new Sprite_Game(0, 0, "button");
        sprite.screenCenter();
        add(sprite);

        if (FlxG.sound.music == null || !FlxG.sound.music.playing) // don't restart the music if it's already playing
        {
            switch(FlxG.random.int(0,1)){
                case 0:
                FlxG.sound.playMusic(Paths.music('buttonClicker'), 1, true);
                case 1:
                FlxG.sound.playMusic(Paths.music('beginning'), 1, true);
                case 2:
                FlxG.sound.playMusic(Paths.music('peace'), 1, true);
                default:
                FlxG.sound.playMusic(Paths.music('buttonClicker'), 1, true);
            }
        }

        callOnScripts('createPost', []);

        FlxG.signals.preStateSwitch.add(destroy);
    }

    override public function update(elapsed:Float)
    {
        callOnScripts('update', [elapsed]);

        super.update(elapsed);

        FlxTween.color(bg, 1, 0x006EFF, 0x550404,
			{type: FlxTweenType.PINGPONG, ease: FlxEase.sineInOut});

        coinTxt.text = "Coin: " + FlxG.save.data.coin + 
        if (FlxG.save.data.autoTap == true) 
            " | Auto Tap is Enable";
        else
            "";

        var options = FlxG.keys.justPressed.Q;
        var press = FlxG.keys.justPressed.ENTER;
        var press_alt = FlxG.keys.justPressed.SPACE;
        var store = FlxG.keys.justPressed.S;
        var reset = FlxG.keys.justPressed.R;
        var devThing = FlxG.keys.justPressed.L;
        var mod = FlxG.keys.justPressed.F1;
        var sercet = FlxG.keys.justPressed.F12;
        var update = FlxG.keys.justPressed.F11;

        if (update)
        {
            FlxG.switchState(new update.BeforeUpdateState());
        }
        
        if (sercet) //found the sercet
        {
            FlxG.switchState(new SecretState());
        }

        if (mod)
        {
            FlxG.switchState(new ModState());

            FlxG.save.flush();
        }

        if (options)
        {
            FlxG.switchState(new OptionsState());

            FlxG.save.flush();
        }

        if (store)
        {
            trace('welcome');

            FlxG.switchState(new StoreState());

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }

            FlxG.save.flush();
        }

        function click(){
            new FlxTimer().start(0.01, function(timer){
                sprite.animation.play('tap');

                if (FlxG.save.data.x2 == true)
                    FlxG.save.data.coin += 2;
                else
                    FlxG.save.data.coin++;
    
                FlxG.save.flush();
            });
        }

        if (press || press_alt || FlxG.mouse.overlaps(sprite) && FlxG.mouse.justPressed || autoTap() && FlxG.elapsed % 2 == 0)
        {
            click();
        }

        if (reset){
            FlxG.save.data.coin = 0;
            FlxG.save.data.autoTap = false;
            FlxG.save.data.x2 = false;
            SystemData.ownItem = false; 
            FlxG.sound.play(Paths.sound('resetSound'), 1);

            // openSubState(new ResetState());
        }

        if (devThing){
            // #if sys
            // if (Sys.args().contains('dev mode')){
            //     FlxG.save.data.coin += 9999;
            // }
            // #else
            // trace('you do not have dev mode enabled');
            // #end
            // so like hack system
            #if macro
            if (@:privateAccess Macros.getDefine('dev mode')){//I'm too lazy
                FlxG.save.data.coin += 9999;
            }
            else {
                trace('you do not have dev mode enabled');
            }
            #else
            trace('platform does not support dev mode');
            #end
        }

        if (FlxG.save.data.autoTap == true){
            autoTap(true);
        }
        else {
            autoTap(false);
        }

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad == null){
            // trace("No controller detected!");
            checkText.text = "";
		} else {
            // trace("Controller detected!, read controller.txt file");
            // checkText.text = "Controller detected!";
            Application.current.window.title = "Simple Clicker Game - Controller detected!";
			getControls(gamepad);
		}

        callOnScripts('updatePost', [elapsed]);
    }

    inline function autoTap(enabled:Bool = false):Bool
    {
        //loop forever
        return enabled;
    }

    public static function getControls(gamepad:FlxGamepad) {
        if (gamepad.justPressed.X 
            || gamepad.justPressed.Y 
            || gamepad.justPressed.A 
            || gamepad.justPressed.B 
            || gamepad.justPressed.LEFT_STICK_CLICK 
            || gamepad.justPressed.RIGHT_STICK_CLICK
        ){
            // sprite.animation.play('tap');
            sprite.playAnimation("tap");

            if (FlxG.save.data.x2 == true)
                FlxG.save.data.coin += 2;
            else
                FlxG.save.data.coin++;

            FlxG.save.flush();
        }

        if (gamepad.justPressed.BACK){
            FlxG.switchState(new ModState());

            FlxG.save.flush();
        }

        if (gamepad.justPressed.RIGHT_SHOULDER){
            FlxG.save.data.coin = 0;
            FlxG.save.data.autoTap = 0;
            FlxG.save.data.x2 = 0;
            SystemData.ownItem = false; 
            FlxG.sound.play(Paths.sound('resetSound'), 1);
        }

        if (gamepad.justPressed.LEFT_SHOULDER){
            #if macro
            if (@:privateAccess Macros.getDefine('dev mode')){//I'm too lazy
                FlxG.save.data.coin += 9999;
            }
            else {
                trace('you do not have dev mode enabled');
            }
            #else
            trace('platform does not support dev mode');
            #end
        }

        if (gamepad.justPressed.START){
            trace('welcome');

            FlxG.switchState(new StoreState());

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }

            FlxG.save.flush();

            if (FlxG.sound.music != null){
                FlxG.sound.music.stop();
            }
        }

        if (gamepad.justPressed.RIGHT_TRIGGER){
            FlxG.switchState(new OptionsState());

            FlxG.save.flush();
        }
	}

    override public function destory(){
        callOnScripts('destroy', []);
		super.destroy();
        sprite = null;
        coinTxt = null;
        checkText = null;
        sprite_tween = null;
        // gamepad = null;

        for (script in scriptArray)
			script?.destroy();
		scriptArray = [];

        FlxG.signals.preStateSwitch.remove(destroy);
    }

	private function callOnScripts(funcName:String, args:Array<Dynamic>):Dynamic {
		var value:Dynamic = HscriptTool.Function_Continue;

		for (i in 0...scriptArray.length) {
			final call:Dynamic = scriptArray[i].executeFunc(funcName, args);
			final bool:Bool = call == Hscript.Function_Continue;
			if (!bool && call != null)
				value = call;
		}

		return value;
	}
}