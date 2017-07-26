package exporter;

/**
 *  Geometry vertex
 */
@:keep
class Vertex {

    /**
     *  X position
     */
    public var x : Float;

    /**
     *  Y position
     */
    public var y : Float;

    /**
     *  Z position
     */
    public var z : Float;

    /**
     *  Constructor
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function new (x : Float, y : Float, z : Float) {
        this.x = x;
        this.y = y;
        this.z = z;
    } 
}