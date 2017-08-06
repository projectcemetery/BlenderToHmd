package io;

/**
 *  Vertex weight
 */
class Weight {

    /**
     *  Weight
     */
    public var weight (default, null) : Float;

    /**
     *  Bone index
     */
    public var boneIndex (default, null) : Int;

    /**
     *  Constructor
     *  @param weight - 
     *  @param boneIndex - 
     */
    public function new (weight : Float, boneIndex : Int) {
        this.weight = weight;
        this.boneIndex = boneIndex;
    }
}