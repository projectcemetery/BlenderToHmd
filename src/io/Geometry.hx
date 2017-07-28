package io;

/**
 *  Model geometry
 */
@:keep
class Geometry {

    /**
     *  Vertex array
     */
    public var triangles (default, null) : Array<Triangle>;

    /**
     *  Geometry has uv
     */
    public var hasUv : Bool;

    /**
     *  Constructor
     */
    public function new () {
        triangles = new Array<Triangle> ();
    }

    /**
     *  Add triangle
     *  @param verts - 
     */
    public function addTriangle (triangle : Triangle) : Void {
        triangles.push (triangle);
    }
}