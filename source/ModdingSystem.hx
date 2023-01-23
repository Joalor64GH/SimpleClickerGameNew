package;

import openfl.utils.AssetLibrary;
import openfl.utils.Assets;
using HScriptTool;

//**Kinda based on Yoshicrafters Codename engine**/
class ModdingSystem extends HScriptTool implements IHScriptTool {
    public static final modsFolder:String = 'pack_mods/';
    public static var loadedMods:Map<String, lime.utils.AssetLibrary> = [];
    public static var libraries:Array<AssetLibrary> = [];

    public function new(/*?mod:Null<String>, ?force:Bool = false*/){
        /*try{
            if(modFolderExists()){
                if (getFolders('$modsFolder').endsWith('mods/')){
                    trace('Mods folder exists, searching for existing mods');
                    if (libraries.exists('${modsFolder}$mod')){
                        loadMod(mod, force);
                    }
                }
            }
        }
        catch(e:haxe.Exception){
            trace(e.details());
        }*/
        super();
    }

    public function loadMod(mod:Null<String>, force:Bool = false){
        #if sys
        if (mod == null) return null; // in case the mod doesn't exist

        if (sys.FileSystem.exists('${modsFolder}$mod') && sys.FileSystem.isDirectory('${modsFolder}$mod')){
            return loadedMods[mod] = Assets.loadLibrary('${modsFolder}$mod'.toLowerCase()).onComplete(function(e){
                trace('Mod loaded: ${modsFolder}$mod');
            });
        }
        else {
            return null;
            trace('Mod could not be found.');
        }
        #else
        return null;
        #end
    }

    // mostly a copy of above but whatever fuck you I don't care
    public function unloadMod(mod:Null<String>){
        #if sys
        if (mod == null) return; // in case the mod doesn't exist

        if (sys.FileSystem.exists('${modsFolder}$mod') && sys.FileSystem.isDirectory('${modsFolder}$mod')){
            loadedMods[mod] = Assets.unloadLibrary('${modsFolder}$mod'.toLowerCase());
        }
        else {
            return;
            trace('Mod could not be found.');
        }
        #else
        return;
        #end
    }

    inline public function modFolderExists():Bool{
        return (sys.FileSystem.exists('$modsFolder') && sys.FileSystem.isDirectory('$modsFolder')); 
    }

    public function getFiles(file:String){
        var folders:Array<String> = [];
        for (e in libraries){
            if (libraries.indexOf('$folder')){
                // Assets.loadLibrary('${folder}'.toLowerCase()).onComplete(function(e) {trace(e)});
                return; // my brain hurts :P
            }
            else{
                if (folders.indexOf(file))
                    folders.push(file);
            }
        }
        return folders;
    }    

    public function getFolders(folder:String){
        var folders:Array<String> = [];
        for (e in libraries){
            if (libraries.indexOf('$folder')){
                return;
            }
            else{
                folders.push(e);
            }
        }
        return folders;
    }

    inline public function modExists(mod:Null<String>){
        #if sys
        return (sys.FileSystem.exists('${modsFolder}$mod') && sys.FileSystem.isDirectory('${modsFolder}$mod'));
        #else
        return null;
        #end
    }

    inline public function readFile(file:Null<String>){
        #if sys
        return sys.FileSystem.exists('$file') ? sys.io.File.getContent(file) : null;
        #else
        return null;
        #end
    }
}