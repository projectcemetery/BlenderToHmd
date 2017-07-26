package exporter;

/**
 *  Model geometry
 *  For python plugin
 */
@:keep
class Mesh {

    /**
     *  Vertex array
     */
    public var vertexArray (default, null) : Array<Vertex>;

    /**
     *  Constructor
     */
    public function new () {
        vertexArray = new Array<Vertex> ();
    }

    /**
     *  Add vertex to geometry
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function addVertex (x : Float, y : Float, z : Float) : Void {
        vertexArray.push (new Vertex (x, y, z));
    }
}