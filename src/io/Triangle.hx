package io;

/**
 *  Geometry triangle
 */
@:keep
class Triangle {

    /**
     *  Vertex array
     */
    public var vertexArray : Array<Vertex>;

    /**
     *  Constructor
     */
    public function new () {
        vertexArray = new Array<Vertex> ();
    }

    /**
     *  Add vertex
     *  @param verts - 
     */
    public function addVertex (vertex : Vertex) : Void {
        if (vertexArray.length >= 3) throw "Too many vertex for triangle";
        vertexArray.push (vertex);
    }

}