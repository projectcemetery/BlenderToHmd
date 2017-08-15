package io;

/**
 *  Skin data
 */
@:keep
class Skin {

    /**
     *  Skin joints
     */
    public var joints (default, null) : Array<Joint>;

    /**
     *  Constructor
     */
    public function new () {
        joints = new Array<Joint> ();
    }

    /**
     *  Add joint
     *  @param joint - 
     */
    public function addJoint (joint : Joint) : Void {
        joints.push (joint);
    }
}