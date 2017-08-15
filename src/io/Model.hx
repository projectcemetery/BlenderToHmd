package io;

/**
 *  Model
 */
@:keep
class Model {

    /**
     *  Model name
     */
    public var name : String = "Object";

    /**
     *  Model geometry
     */
    public var geometry : Geometry;

    /**
     *  Skin data
     */
    public var skin : Skin;

    /**
     *  Constructor
     */
    public function new () {
    }
}