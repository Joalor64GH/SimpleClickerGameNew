package;

class PlatformUtils{
    public static var buildTarget:Array<String> = [];

    inline static function getPlatform(){
        #if windows
        buildTarget.insert('windows');
        #elseif linux
        buildTarget.insert('linux');
        #elseif mac
        buildTarget.insert('mac');
        #elseif html5
        buildTarget.insert('browser');
        #elseif android
        buildTarget.insert('android');
        #elseif ios
        buildTarget.insert('ios');
        #elseif hl
        buildTarget.insert('hl');
        #else
        buildTarget.insert('unknown');
        #end

        return buildTarget;
    }
}