package;

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
	public static macro function getDefines():haxe.macro.Expr
	{
		return macro $v{haxe.macro.Context.getDefines()};
	}
}