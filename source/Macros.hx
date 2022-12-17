package;

#if macro
class Macros
{
	// Shorthand for retrieving compiler flag values.
	static macro function getDefine(key:String):haxe.macro.Expr
	{
		return macro $v{haxe.macro.Context.definedValue(key)};
	}

	// Shorthand for setting compiler flags.
	static macro function setDefine(key:String, value:String):haxe.macro.Expr
	{
		haxe.macro.Compiler.define(key, value);
		return macro null;
	}

	// Shorthand for checking if a compiler flag is defined.
	static macro function isDefined(key:String):haxe.macro.Expr
	{
		return macro $v{haxe.macro.Context.defined(key)};
	}

	// Shorthand for retrieving a map of all defined compiler flags.
	static macro function getDefines():haxe.macro.Expr
	{
		var defines:Map<String, String> = haxe.macro.Context.getDefines();
		// Construct map syntax so we can return it as an expression
		var map:Array<haxe.macro.Expr> = [];
		for (key in defines.keys())
		{
			map.push(macro $v{key} => $v{Std.string(defines.get(key))});
		}
		return macro $a{map};
	}
}
#end