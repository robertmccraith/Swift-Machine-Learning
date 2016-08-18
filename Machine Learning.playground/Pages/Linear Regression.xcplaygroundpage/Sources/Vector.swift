//
//  vector.swift
//  
//
//  Created by Robert McCraith on 13/08/2016.
//
//

import Foundation


public class Vector:CustomStringConvertible {
    
    public var v:[Double] = []
    public var col:[[Double]] { get{ return transpose(v: v) } }
    
    public var length:Int { get{ return v.count } }
    public var T:[[Double]] {get { return transpose(v: v) } }
    
    public init() { }
    
    public init(value: Double, length:Int)
    {
        v = [Double](repeating: value, count: length)
    }
    
    
    public subscript(i:Int)->Double
    {
        get{
                return v[i]
        }
        set(val){
            v[i] = val
        }
    }
    
    
    public init(array: [Double]) {
        v = array
    }
    public func append(a:Double){
        v.append(a)
    }
    
    
    public func dot(b:Vector)->Double{
        var sum = 0.0
        for i in 0..<length{
            sum += self.v[i]*b.v[i]
        }
        return sum
    }

    
    public func transpose(v: [Double]) -> [[Double]] {
        var newMat:[[Double]] = []
        
        for i in 0..<v.count{
            newMat.append([v[i]])
        }
        
        return newMat
    }
    
    
    static public func *(x:Double, r:Vector)->Vector{
        let ans = r
        for i in 0..<ans.length {
            ans.v[i] *= x
        }
        
        return ans
    }
    
    static public func -(l:Vector, r:Vector)->Vector{
        
        for i in 0..<l.length {
            l.v[i] -= r.v[i]
        }
        
        
        return l
    }
    
    public var description: String {
        
        return  self.v.description
    }
}
