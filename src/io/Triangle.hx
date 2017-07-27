package io;

import h3d.Vector;
import h3d.prim.UV;

/**
 *  Geometry triangle
 */
@:keep
class Triangle {

    /**
     *  Triangle vertices
     */
    public var vertices (default, null) : Array<Vector>;

    /**
     *  Triangle normals
     */
    public var normals (default, null) : Array<Vector>;

    /**
     *  Triangle uv
     */
    public var uvs (default, null) : Array<UV>;

    /**
     *  Constructor
     */
    public function new () {
        vertices = new Array<Vector> ();
        normals = new Array<Vector> ();
        uvs = new Array<UV> ();
    }
    
    /**
     *  Add vertex
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function addVertex (x : Float, y : Float, z : Float) : Void {
        if (vertices.length >= 3) throw "Too much vertex for triangle";
        vertices.push (new Vector (x,y,z));
    }

    /**
     *  Add vertex
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function addNormal (x : Float, y : Float, z : Float) : Void {
        if (normals.length >= 3) throw "Too much normals for triangle";
        normals.push (new Vector (x,y,z));
    }

    /**
     *  Add uv
     *  @param u - 
     *  @param v - 
     */
    public function addUv (u : Float, v : Float) : Void {
        if (uvs.length >= 3) throw "Too much uv for triangle";
        uvs.push (new UV (u, v));
    }
}