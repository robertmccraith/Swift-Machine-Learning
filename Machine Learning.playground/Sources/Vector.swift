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
	
    
    public var length:Int { get{ return v.count } }
    public var T:Matrix {get { return transpose() } }
	public var row:Matrix { get {return Matrix(rows: 1, cols: self.length, arr: self.v)} }
	public var col:Matrix { get {return Matrix(rows: self.length, cols: 1, arr: self.v)} }
    
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
	
	public subscript(range:Range<Int>)->Vector
	{
		get{
			return Vector(array: Array(v[range]))
		}
		set(val){
			self.v.replaceSubrange(range, with: val.v)
		}
	}
	
	
    public init(array: [Double]) {
        v = array
    }
    public func append(a:Double){
        v.append(a)
    }
	
	public func insert(a:Double, at index:Int)->Vector{
		let vec = self.copy() as! Vector
		vec.v.insert(a, at: index)
		return vec
	}
	
    static public func *(l:Vector, r:Vector)->Double{

        var sum = 0.0
        for i in 0..<l.length{
            sum += l[i]*r[i]
        }
        return sum
    }
	
	static public func .*(l:Vector, r:Vector)->Vector{
		let l = l.copy() as! Vector
		for i in 0..<l.length{
			l[i] *= r[i]
		}
		return l
	}
	
	static public func /(l:Vector, r:Vector)->Vector{
		let l = l.copy() as! Vector
		
		for i in 0..<l.length{
			l[i] /= r[i]
		}
		return l
		
	}
	
    public func transpose() -> Matrix {
        let newMat = Matrix()
        
        for i in 0..<self.length{
			var arr:[Double] = []
			arr.append(self[i])
			newMat.m.append( Vector(array: [self[i]] ))
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
	
	static public func /(v:Vector, c:Double)->Vector
	{
		let vec = v.copy() as! Vector
		
		vec.v = vec.v.map({$0/c})
		
		return vec
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
		//return "\(self.length)"
		
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
