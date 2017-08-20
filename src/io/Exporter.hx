package io;

import hxd.fmt.hmd.Writer;
import hxd.fmt.hmd.Data;
import h3d.col.Bounds;
import haxe.io.Bytes;
import haxe.io.BytesOutput;
import h3d.mat.BlendMode;

/**
 *  For working with hmd
 */
@:keep
class Exporter {

    /**
     *  Data for vertex, index, animation, etc
     */
    var dataBytes : BytesOutput;

    /**
     *  Convert int to float
     *  @param v - 
     *  @return Float
     */
    function int32ToFloat (v : Int) : Float {
        var tmp = haxe.io.Bytes.alloc(4);
		tmp.set(0, v & 0xFF);
		tmp.set(1, (v >> 8) & 0xFF);
		tmp.set(2, (v >> 16) & 0xFF);
		tmp.set(3, v >>> 24);
		return tmp.getFloat(0);
	}

    /**
     *  Get skin for export
     *  @param skin - 
     */
    function getSkin (skin : io.Skin) : Skin {
        var nskin = new Skin ();
        nskin.name = "Skin";
        nskin.joints = new Array<SkinJoint> ();

        for (j in skin.joints) {
            var njoint = new SkinJoint ();
            njoint.name = j.name;
            njoint.parent = 0;
            njoint.bind = 0;

            njoint.position = new Position ();
            njoint.position.x = j.position.x;
            njoint.position.y = j.position.y;
            njoint.position.z = j.position.z;
            njoint.position.qx = 0;
            njoint.position.qy = 0;
            njoint.position.qz = 0;
            njoint.position.sx = 1;
            njoint.position.sy = 1;
            njoint.position.sz = 1;

            njoint.transpos = new Position ();
            njoint.transpos.x = 0;
            njoint.transpos.y = 0;
            njoint.transpos.z = 0;
            njoint.transpos.qx = 0;
            njoint.transpos.qy = 0;
            njoint.transpos.qz = 0;
            njoint.transpos.sx = 1;
            njoint.transpos.sy = 1;
            njoint.transpos.sz = 1;

            nskin.joints.push (njoint);
        }

        return nskin;
    }

    /**
     *  Write geometry vertex
     *  @param geom - 
     *  @param bytes - 
     */
    function writeVertex (geom : io.Geometry, bytes : BytesOutput) : Void {
        for (vert in geom.vertexArray) {
            bytes.writeFloat (vert.position.x);
            bytes.writeFloat (vert.position.y);
            bytes.writeFloat (vert.position.z);
            bytes.writeFloat (vert.normal.x);
            bytes.writeFloat (vert.normal.y);
            bytes.writeFloat (vert.normal.z);

            if (geom.hasUv) {
                bytes.writeFloat (vert.uv.u);
                bytes.writeFloat (vert.uv.v);
            }

            if (geom.hasWeights) {
                for (w in vert.weights) {
                    bytes.writeFloat (w.weight);
                }

                var idx = 0;
                for (w in vert.weights) {
                    idx = (idx << 8) | w.boneIndex;
                }

                bytes.writeFloat (int32ToFloat (idx));
            }
        }
    }

    /**
     *  Add model to HMD
     */

    function addModel (hmd : Data, model : io.Model) : Void {
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

        if (egeom.hasWeights) {
            ngeom.vertexStride += 4;
            var pw = new GeometryFormat ("weights", [DFloat, DVec2, DVec3, DVec4][model.skin.bonePerVertex - 1]);
            ngeom.vertexFormat.push (pw);
            pw = new GeometryFormat ("indexes", DBytes4);
            ngeom.vertexFormat.push (pw);
        }

        ngeom.indexCounts = [egeom.indexArray.length];
        // TODO: fix bounds
        ngeom.bounds = Bounds.fromValues (0,0,0,1,1,1);        

        var nmodel = new Model ();
        nmodel.name = model.name;
        // TODO: geometry and parent
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

        var bytes = dataBytes;
        var nmat = new Material();
        nmat.name = "Default";
        nmat.blendMode = BlendMode.None;
        nmat.culling = h3d.mat.Data.Face.Back;        

        hmd.dataPosition = bytes.length;

        writeVertex (egeom, bytes);

        ngeom.indexPosition = bytes.length;

        for (idx in egeom.indexArray) {
            bytes.writeUInt16 (idx);
        }

        if (model.skin != null) {
            nmodel.skin = getSkin (model.skin);
        }

        hmd.geometries.push (ngeom);
        hmd.models.push (nmodel);
        hmd.materials.push (nmat);
    }

    /**
     *  Add animtaion
     */
    function addAnimation (hmd : Data, anim : io.Animation) : Void {
        var bytes = dataBytes;

        var nanim = new Animation ();
        nanim.name = "Animation";
        nanim.frames = anim.frames;
        nanim.loop = true;
        nanim.speed = 1;
        nanim.sampling = 30;
        nanim.dataPosition = bytes.length;
        nanim.objects = new Array<AnimationObject> ();

        for (ao in anim.objectAnimations) {
            var nanimObj = new AnimationObject ();
            nanimObj.name = ao.name;
            nanimObj.flags = new haxe.EnumFlags<AnimationFlag> ();
            nanimObj.flags.set (AnimationFlag.HasPosition);
            nanimObj.flags.set (AnimationFlag.HasRotation);
            nanim.objects.push (nanimObj);

            for (dat in ao.data) {
                bytes.writeFloat (dat.x);
                bytes.writeFloat (dat.y);
                bytes.writeFloat (dat.z);

                if (ao.hasRotation) {
                    bytes.writeFloat (dat.qx);
                    bytes.writeFloat (dat.qy);
                    bytes.writeFloat (dat.qz);
                }
            }
        }

        hmd.animations.push (nanim);
    }

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
        hmd.geometries = new Array<Geometry> ();
        hmd.materials = new Array<Material> ();
        hmd.models = new Array<Model> ();
        hmd.animations = new Array<Animation> ();

        dataBytes = new haxe.io.BytesOutput ();

        for (m in scene.modelArray) {
            addModel (hmd, m);
        }
        
        for (a in scene.animations) {
            addAnimation (hmd, a);
        }

        hmd.data = dataBytes.getBytes ();
        writer.write (hmd);
        sys.io.File.saveBytes (filepath, io.getBytes ());
    }
}