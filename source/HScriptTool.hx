package;

import flixel.FlxG;
import flixel.FlxBasic;
import hscript.*;

// wednedays infidelity moment lol
class Script extends FlxBasic {
    public var parser:Parser;
    public var interp:Interp;

    public function new() {
        parser = new Parser();
        interp = new Interp();
		super();
    }

    public function runScript(script:String){
        try {
            var a = parser.parseString(script);
            interp.execute(a);
        }
        catch (e){
            openfl.Lib.application.window.alert(e.message, "HSCRIPT ERROR!1111");
        }
    }

	inline public function setVariable(name:String, val:Dynamic)
	{
		interp.variables.set(name, val);
	}

	inline public function getVariable(name:String):Dynamic
	{
		return interp.variables.get(name);
	}

    inline public override function exists(name:String):Bool{
        return interp.variables.exists(name);
    }

	public function executeFunc(funcName:String, ?args:Array<Any>):Dynamic
	{
		if (interp == null)
			return null;

		if (interp.variables.exists(funcName))
		{
			var func = interp.variables.get(funcName);
			if (args == null)
			{
				var result = null;
				try
				{
					result = func();
				}
				catch (e)
				{
					trace('$e');
				}
				return result;
			}
			else
			{
				var result = null;
				try
				{
					result = Reflect.callMethod(null, func, args);
				}
				catch (e)
				{
					trace('$e');
				}
				return result;
			}
		}
		return null;
	}

	public override function destroy()
	{
		super.destroy();
		interp = null;
        parser = null;
	}
}

// don't delete this
class HScriptTool extends Script {
    public override function create(){
        super.create();
    }
}	

interface IHScriptTool{
	public function getFolders():Dynamic;
	public function getFiles():Dynamic;

	public function loadMod(mod:Null<String>, force:Bool = false):Void;
	public function unloadMod(mod:Null<String>):Void;
	public function modExists(mod:Null<String>):Bool;
	public function modsFolderExists():Bool;

	public function readFile(file:Null<String>):Dynamic;
}