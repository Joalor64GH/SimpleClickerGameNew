package;

import flixel.ui.FlxButton;
import flixel.FlxState;
import flixel.FlxG;
import lime.app.Application;

class CheckState extends FlxState
{
    var http = new haxe.Http("https://raw.githubusercontent.com/Hoovy-Team/Simple-Clicker-Game/main/version.txt");

    var version = Application.current.meta.get('version');
    var startCheck:FlxButton;

    var check_progress:Int = 0;

    override function create() 
    {
        super.create();

        startCheck = new FlxButton(0, 0, "", will_check);
        startCheck.screenCenter();
        add(startCheck);
    }

    function will_check() //check are now in progress
    {
        check_progress = 1;
        trace('start checking version');
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        startCheck.text = "Click to check version";

        if (check_progress == 1)
        {
            http.onData = function (data:String) {
			  
                if (!version.contains(data.trim()))
				{
					trace('outdated now!!' + data.trim());
					FlxG.switchState(new OutDateState());
				}
				else
				{
					FlxG.switchState(new MainMenuState());
				}
			}
			
			http.request();

            check_progress = 0; //end check
        }
    }
}