package;

import flixel.FlxG;
import flixel.FlxState;

using StringTools;

class StoreState extends FlxState {
    public var coins:Int = 0;

    override public function create(){
        if (FlxG.save.data.coin != null){
            coins = FlxG.save.data.coin;
        }

        super.create();
    }
}