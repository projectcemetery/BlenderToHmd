package io;

import h3d.Vector;
import h3d.Quat;

/**
 *  Skin joint
 */
@:keep
class Joint {

    /**
     *  Joint index
     */
    public var index : Int;

    /**
     *  Index of parent
     */
    public var parentIndex : Int;

    /**
     *  Joint name
     */
    public var name : String;

    /**
     *  Joint position
     */
    public var position (default, null) : Vector;

    /**
     *  Quaternion
     */
    public var quat (default, null) : Quat;

    /**
     *  Constructor
     */
    public function new () {
        position = new Vector (0,0,0,0);
    }

    /**
     *  Set joint position
     *  @param x - 
     *  @param y - 
     *  @param z - 
     */
    public function setPosition (x : Float, y : Float, z : Float) : Void {
        position.x = x;
        position.y = y;
        position.z = z;
    }
}