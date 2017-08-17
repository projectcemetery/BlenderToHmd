package io;

/**
 *  Group of object animations
 */
@:keep
class Animation {    

    /**
     *  Animation of object
     */
    public var objectAnimations (default, null) : Array<ObjectAnimation>;

    /**
     *  Animation frames
     */
    public var frames (default, null) : Int;

    /**
     *  Constructor
     */
    public function new (frames : Int) {
        this.frames = frames;
        objectAnimations = new Array<ObjectAnimation> ();
    }

    /**
     *  Add object animation
     *  @param anim - 
     */
    public function addObjectAnimation (anim : ObjectAnimation) : Void {
        objectAnimations.push (anim);
    }
}