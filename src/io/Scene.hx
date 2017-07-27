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
     *  Constructor
     */
    public function new () {
        modelArray = new Array<Model> ();
    }

    /**
     *  Add model
     *  @param m - 
     */
    public function addModel (m : Model) : Void {
        modelArray.push (m);
    }
}