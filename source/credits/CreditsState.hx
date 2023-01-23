package credits;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;

using flixel.util.FlxSpriteUtil;

class CreditsState extends FlxState
{
    var creditsList:Array<String> = [];

	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	var text:FlxText;

	override public function create()
	{
		super.create();

        creditsList = SystemData.assetsFile(Paths.txt("credits"));

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		text = new FlxText(0, 0, 0, "", 16);
        text.screenCenter(X);
        add(text);

		for (i in 0...creditsList.length)
		{
			var optionText:FlxText = new FlxText(0, 300 + (i * 50), 0, creditsList[i], 32);
			optionText.ID = i;
			optionText.screenCenter(X);
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		text.text = "Simple Clicker Game - Credits";

        var up = FlxG.keys.justPressed.UP;
        var down = FlxG.keys.justPressed.DOWN;
        var enter = FlxG.keys.justPressed.ENTER;

		if (up)
			curSelected -= 1;

		if (down)
			curSelected += 1;

		if (curSelected < 0)
			curSelected = creditsList.length - 1;

		if (curSelected >= creditsList.length)
			curSelected = 0;

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});

		if (enter)
		{
			switch (creditsList[curSelected])
			{
				case "Huy1234TH":
					openSubState(new Huy1234thSubState());
					CreditsBool.huy1234th = true;

				case "Back":
					FlxG.switchState(new OptionsState());
			}
		}
	}
}

class Huy1234thSubState extends FlxSubState
{
	override public function create()
	{
		super.create();

		var text = new FlxText();
		text.text = "Huy1234TH\nCreator of the Project\nThis link will move to the web browser!\nDo you want to continue?";
		text.color = FlxColor.PINK;
		text.size = 16;
		text.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.RED, 4);
		text.screenCenter();

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(Std.int(text.width + 16), Std.int(text.height + 30 + 36),
			FlxColor.WHITE);
		FlxSpriteUtil.drawRect(bg, 1, 1, bg.width - 2, bg.height - 2, FlxColor.YELLOW);
		bg.screenCenter();

		add(bg);
		add(text);

		bgColor = 0;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	
		if (FlxG.keys.justPressed.ENTER){
			FlxG.openURL("https://www.youtube.com/channel/UCHLN1cnuBhRvPBgrhARqp2A");
		}

		if (FlxG.keys.justPressed.ESCAPE){
			close();
		}
	}
}