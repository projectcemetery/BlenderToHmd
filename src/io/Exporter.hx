package io;

import hxd.fmt.hmd.Writer;
import hxd.fmt.hmd.Data;
import h3d.col.Bounds;
import haxe.io.Bytes;

/**
 *  For working with hmd
 */
@:keep
class Exporter {    

    /**
     *  Constructor
     */
    public function new () {
    }

    /**
     *  Write scene
     *  @param filepath - 
     *  @param scene - 
     */
    public function write (filepath : String, scene : Scene) : Void {
        sys.io.File.saveContent (filepath, haxe.Json.stringify (scene, null, " "));

        /*var io = new haxe.io.BytesOutput ();
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
        ngeom.indexPosition = 0;
        ngeom.bounds = Bounds.fromValues (0,0,0,1,1,1);

        hmd.materials = new Array<Material> ();
        hmd.models = new Array<Model> ();
        hmd.animations = new Array<Animation> ();        
        hmd.dataPosition = 0;        
        hmd.data = Bytes.alloc(0);
        
        writer.write (hmd);
        sys.io.File.saveBytes (filepath, io.getBytes ());*/
    }
}