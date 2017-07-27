package io;

import h3d.Vector;
import h3d.prim.UV;

/**
 *  Geometry vertex
 */
@:keep
class Vertex {

    /**
     *  Vertex position
     */
    public var position (default, null) : Vector;

    /**
     *  Vertex normal
     */
    public var normal (default, null) : Vector;

    /**
     *  Vertex uv
     */
    public var uv (default, null) : UV;

    /**
     *  Constructor
     */
    public function new () {
        position = new Vector ();
        normal = new Vector ();
        uv = new UV (0,0);
    }
    
    /**
     *  Set position
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function setPosition (x : Float, y : Float, z : Float) : Void {
        position.x = x;
        position.y = y;
        position.z = z;
    }

    /**
     *  Add vertex
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function setNormal (x : Float, y : Float, z : Float) : Void {        
        normal.x = x;
        normal.y = y;
        normal.z = z;
    }

    /**
     *  Add uv
     *  @param u - 
     *  @param v - 
     */
    public function setUv (u : Float, v : Float) : Void {
        uv.u = u;
        uv.v = v;
    }
}