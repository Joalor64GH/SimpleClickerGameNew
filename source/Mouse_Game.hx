package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flixel.input.mouse.FlxMouse;

class Mouse_Game extends FlxMouse
{
	var _mouse:Bitmap = null;
	var scale:Float = 1;

	public function new(_mouse:Bitmap = null, scale:Float = 1)
	{
		super(_mouse, scale);
        trace('mouse file');
	}
}
