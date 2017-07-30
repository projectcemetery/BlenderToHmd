package io;

/**
 *  Model geometry
 */
@:keep
class Geometry {

    /**
     *  Vertex array
     */
    public var vertexArray (default, null) : Array<Vertex>;

    /**
     *  Index array
     */
    public var indexArray (default, null) : Array<Int>;

    /**
     *  Geometry has uv
     */
    public var hasUv : Bool;

    /**
     *  Constructor
     */
    public function new () {
        vertexArray = new Array<Vertex> ();
        indexArray = new Array<Int> ();
    }

    /**
     *  Add verted
     *  @param verts - 
     */
    public function addVertex (vertex : Vertex) : Void {
        vertexArray.push (vertex);
    }

    /**
     *  Add index
     *  @param index - 
     */
    public function addIndex (index : Int) : Void {
        indexArray.push (index);
    }
}