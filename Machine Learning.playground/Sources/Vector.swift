//
//  vector.swift
//  
//
//  Created by Robert McCraith on 13/08/2016.
//
//

import Foundation
import Cocoa


public class Vector:CustomStringConvertible, NSCopying {
	
    
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
    
    
    static public func *(l:Vector, r:Vector)->Double{
		let l = l.copy() as! Vector
		let r = r.copy() as! Vector
        var sum = 0.0
        for i in 0..<l.length{
            sum += l[i]*r[i]
        }
        return sum
    }
	
	public func mult( r:Vector)->Vector{
		let l = Vector(array: v)
		let r = r.copy() as! Vector
		
		for i in 0..<l.length{
			l[i] *= r[i]
		}
		return l
	}
	
	static public func /(l:Vector, r:Vector)->Vector{
		let l = l.copy() as! Vector
		let r = r.copy() as! Vector
		
		for i in 0..<l.length{
			l[i] /= r[i]
		}
		return l
		
	}
	
    public func transpose(v: [Double]) -> [[Double]] {
        var newMat:[[Double]] = []
        
        for i in 0..<v.count{
            newMat.append([v[i]])
        }
        
        return newMat
    }
    
	static public func ^(x:Vector, r:Double)->Vector
	{
		let x = x.copy() as! Vector
		for i in 0..<x.length {
			x[i] = pow(x[i],r)
		}
		return x
	}
 
	
    static public func *(x:Double, r:Vector)->Vector
	{
		let r = r.copy() as! Vector
        for i in 0..<r.length {
            r[i] *= x
        }
        
        return r
    }
	
	static public func +(l:Vector, r:Vector)->Vector{
		let l = l.copy() as! Vector
		let r = r.copy() as! Vector
		
		for i in 0..<l.length {
			l.v[i] += r.v[i]
		}
		return l
	}
	
    static public func -(l:Vector, r:Vector)->Vector{
		let l = l.copy() as! Vector
		let r = r.copy() as! Vector
		
        for i in 0..<l.length {
            l.v[i] -= r.v[i]
        }
        return l
    }
    
    static public func -(l:Double, r:Vector)->Vector
	{
        let r = r.copy() as! Vector
        for i in 0..<r.length {
            r.v[i] = 1 - r.v[i]
        }
        return r
    }
    
    
    static public prefix func -(vector:Vector)->Vector
    {
        let vec = vector.copy() as! Vector
        vec.v = vec.v.map({-$0})
        return vec
    }
    
    public var description: String {
        
        return  self.v.description
    }
    
    public func logV(v:Vector)->Vector
    {
        v.v = v.v.map({ Darwin.log($0)  })
        return v
    }
	
	public func copy(with zone: NSZone? = nil) -> Any {
		let copy = Vector(array: v)
		
		return copy
	}
	
	
	
    
}
