import hxd.fmt.hmd.Writer;
import hxd.fmt.hmd.Data;
import h3d.col.Bounds;

/**
 *  For working with hmd
 */
@:keep
class Hmd {

    /**
     *  Constructor
     */
    public function new () {
    }

    public function write (filepath : String) : Void {
        var io = new haxe.io.BytesOutput ();
        var writer = new Writer (io);
        var hmd = new Data ();
        hmd.version = Data.CURRENT_VERSION;
        hmd.geometries = new Array<Geometry> ();

        var ngeom = new Geometry();
        ngeom.vertexCount = 24;
        ngeom.vertexStride = 6;
        var pf = new GeometryFormat ("position", GeometryDataFormat.DVec3);
        var pn = new GeometryFormat ("normal", GeometryDataFormat.DVec3);
        ngeom.vertexFormat = [pf, pn];
        hmd.geometries.push (ngeom);
        ngeom.vertexPosition = 0;
        ngeom.indexCounts = [36];
        ngeom.indexPosition = 576;
        ngeom.bounds = Bounds.fromValues (0,0,0,1,1,1);

        writer.write (hmd);
        hxd.fmt.hmd.Dump
        sys.io.File.saveBytes (filepath, io.getBytes ());
    }
}