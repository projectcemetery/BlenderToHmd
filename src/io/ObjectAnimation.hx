package io;

import hxd.fmt.hmd.Data;

/**
 *  Animation of object
 */
@:keep
class ObjectAnimation {

    /**
     *  Object name
     */
    public var name : String;

    
    /**
     *  Animation has rotation
     */
    public var hasRotation (default, null) : Bool;

    /**
     *  Animation has scale
     */
    public var hasScale (default, null) : Bool;

    /**
     *  Array of animation data
     */
    public var data : Array<Position>;

    /**
     *  Constructor
     */
    public function new (hasRotation : Bool, hasScale : Bool) {
        data = new Array<Position> ();
        this.hasRotation = hasRotation;
        this.hasScale = hasScale;
    }

    /**
     *  Add animation frame
     *  @param x - 
     *  @param y - 
     *  @param z - 
     *  @param qx - 
     *  @param qy - 
     *  @param qz - 
     *  @param sx - 
     *  @param sy - 
     *  @param sz - 
     */
    public function addFrame (x : Float, y : Float, z : Float, 
                              ?qx : Float, ?qy : Float, ?qz : Float, 
                              ?sx : Float, ?sy : Float, ?sz : Float) : Void 
    {
        var pos = new Position ();
        pos.x = x;
        pos.y = y;
        pos.z = z;
        pos.qx = 0;
        pos.qy = 0;
        pos.qz = 0;
        pos.sx = 1;
        pos.sy = 1;
        pos.sz = 1;

        if (hasRotation && qx != null && qy != null && qz != null) {
            pos.qx = qx;
            pos.qy = qy;
            pos.qz = qz;
        }

        if (hasScale && sx != null && sy != null && sz != null) {
            pos.sx = sx;
            pos.sy = sy;
            pos.sz = sz;
        } 

        data.push (pos);
    }
}