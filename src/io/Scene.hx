package io;

/**
 *  Scene
 */
@:keep
class Scene {

    /**
     *  Models
     */
    public var modelArray (default, null) : Array<Model>;

    /**
     *  Animations
     */
    public var animations (default, null) : Array<Animation>;

    /**
     *  Constructor
     */
    public function new () {
        modelArray = new Array<Model> ();
        animations = new Array<Animation> ();
    }

    /**
     *  Add model
     *  @param m - 
     */
    public function addModel (m : Model) : Void {
        modelArray.push (m);
    }

    /**
     *  Add animation
     *  @param a - 
     */
    public function addAnimation (a : Animation) : Void {
        animations.push (a);
    }
}