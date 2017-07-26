import hxd.fs.Convert.ConvertFBX2HMD;

/*class DumperApp extends hxd.App {

    override function init () : Void {
        var hmd = hxd.Res.cube.toHmd ();
        var dump = new hxd.fmt.hmd.Dump ();
        var data = hmd.header;
        data.data = hmd.getData ();
        trace (dump.dump (data));
    }
}*/


class Dumper {
    static function main() {
        var convert = new ConvertFBX2HMD ();
        var path = sys.FileSystem.absolutePath (".") + "/res";

        convert.srcBytes = sys.io.File.getBytes ('$path/cube.fbx');
        convert.srcFilename = "cube.fbx";
        convert.srcPath = path;
        convert.dstPath = '$path/cube.hmd';
        convert.convert ();

        var hmd = sys.io.File.getBytes ('$path/cube.hmd');
        var reader = new hxd.fmt.hmd.Reader (new haxe.io.BytesInput (hmd, 0, hmd.length));
        var data = reader.read ();
        //var dump = new hxd.fmt.hmd.Dump ();
        trace (haxe.Json.stringify (data, null, " "));
        //new DumperApp ();
    }
}
