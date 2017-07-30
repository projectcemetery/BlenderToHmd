package io;

import hxd.fmt.hmd.Writer;
import hxd.fmt.hmd.Data;
import h3d.col.Bounds;
import haxe.io.Bytes;
import h3d.mat.BlendMode;

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
        sys.io.File.saveContent (filepath + ".trace", haxe.Json.stringify (scene, null, " "));        

        var io = new haxe.io.BytesOutput ();
        var writer = new Writer (io);
        var hmd = new Data ();
        hmd.version = Data.CURRENT_VERSION;        

        var model = scene.modelArray[0];
        var egeom = model.geometry;
        var vertCount = egeom.vertexArray.length;

        var ngeom = new Geometry();        
        ngeom.vertexCount = vertCount;
        ngeom.vertexPosition = 0;
        
        var pf = new GeometryFormat ("position", GeometryDataFormat.DVec3);
        var pn = new GeometryFormat ("normal", GeometryDataFormat.DVec3);
        ngeom.vertexFormat = [pf, pn];

        if (egeom.hasUv) {
            ngeom.vertexStride = 8;
            var pu = new GeometryFormat ("uv", GeometryDataFormat.DVec2);
            ngeom.vertexFormat.push (pu);
        } else {
            ngeom.vertexStride = 6;
        }        
              
        ngeom.indexCounts = [egeom.indexArray.length];
        ngeom.bounds = Bounds.fromValues (0,0,0,1,1,1);        

        var nmodel = new Model ();        
        nmodel.name = model.name;
        nmodel.geometry = 0;
        nmodel.parent = -1;
        nmodel.position = new Position ();
        nmodel.position.x = 0;
        nmodel.position.y = 0;
        nmodel.position.z = 0;        
        nmodel.position.qx = 0;
        nmodel.position.qy = 0;
        nmodel.position.qz = 0;
        nmodel.position.sx = 1;
        nmodel.position.sy = 1;
        nmodel.position.sz = 1;
        nmodel.materials = [0];

        var nmat = new Material();
        nmat.name = "Default";
        nmat.blendMode = BlendMode.None;
        nmat.culling = h3d.mat.Data.Face.Back;

        hmd.geometries = new Array<Geometry> ();
        hmd.materials = new Array<Material> ();
        hmd.models = new Array<Model> ();
        hmd.animations = new Array<Animation> ();        
        hmd.dataPosition = 0;

        hmd.geometries.push (ngeom);
        hmd.models.push (nmodel);
        hmd.materials.push (nmat);

        var bytes = new haxe.io.BytesOutput ();

        for (vert in egeom.vertexArray) {
            bytes.writeFloat (vert.position.x);
            bytes.writeFloat (vert.position.y);
            bytes.writeFloat (vert.position.z);
            bytes.writeFloat (vert.normal.x);
            bytes.writeFloat (vert.normal.y);
            bytes.writeFloat (vert.normal.z);

            if (egeom.hasUv) {
                bytes.writeFloat (vert.uv.u);
                bytes.writeFloat (vert.uv.v);
            }
            
        }

        ngeom.indexPosition = bytes.length;

        for (idx in egeom.indexArray) {
            bytes.writeUInt16 (idx);
        }
        
        hmd.data = bytes.getBytes ();

        writer.write (hmd);
        sys.io.File.saveBytes (filepath, io.getBytes ());
    }
}