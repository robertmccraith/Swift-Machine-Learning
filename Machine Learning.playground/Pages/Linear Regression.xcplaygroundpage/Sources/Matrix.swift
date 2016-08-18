//
//  Matrix.swift
//  
//
//  Created by Robert McCraith on 13/08/2016.
//
//

import Foundation


public class Matrix:CustomStringConvertible {
    
    public var m:[Vector] = []
    public var size:(h:Int, w:Int) {get {return (m.count, m.count>=1 ? m[0].length : 0)} }
    public var T:Matrix {get { return transpose(m: self) } }
    
    public init() {}
    
    public subscript(i:Int, j:Int)->Double
    {
        get{
            return m[i][j]
        }
        set(val){
            m[i][j] = val
        }
    }
    
    public subscript(i:Int)->Vector
    {
        get{
            return m[i]
        }
    }
    
    
    public func dot(b: Vector)->Vector{
        
        let ans = Vector()
        for i in 0..<size.h {
            
            ans.append(a: m[i].dot(b: b))
            
        }
        return ans
    }
    
    
    public func transpose(m: Matrix) -> Matrix {
        let newMat = Matrix()
        
        for i in 0..<m.size.w{
            let v = Vector()
            for j in 0..<m.size.h{
                v.append(a: m.m[j].v[i])
            }
            newMat.m.append(v)
        }
        
        return newMat
    }
    
    static public func +(l:Matrix, r:Matrix)->Matrix{
        let ans = l
        for i in 0..<l.size.h{
            for j in 0..<l.size.w{
                ans.m[i].v[j] += r.m[i].v[j]
            }
        }
        return ans
    }
    
    static public func *(x:Double, r:Matrix)->Matrix{
        let ans = r
        for i in 0..<r.size.h{
            for j in 0..<r.size.w{
                ans.m[i].v[j] *= Double(x)
            }
        }
        return ans
    }
    
    public var description: String {
        return self.m.map({$0.description}).reduce("[", {$0+"\n"+$1}) + "\n]"
    }
    
    
    public func prepend(a:Double) -> Matrix {
        let mat = self.T

        let ma = Matrix()
        ma.m.append(Vector(value: a, length:mat.size.w))
        
        ma.m.append(contentsOf: mat.m)
        
        return ma.T
    }
    
}

