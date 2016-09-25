//
//  Matrix.swift
//
//
//  Created by Robert McCraith on 13/08/2016.
//
//

import Foundation
import Accelerate

infix operator .*


public class Matrix:CustomStringConvertible, NSCopying {
	
	public var m:[Vector] = []
	public var rows:Int {get {return m.count} }
	public var cols:Int {get {return m.count>=1 ? m[0].length : 0} }
	public var shape:(rows:Int,cols:Int){get{return (self.rows, self.cols)}}
	public var T:Matrix {get { return transpose(m: self) } }
	
	
	
	
	public init() {}
	
	public init(diag:Double, size:Int)
	{
		for i in 0..<size{
			let vector = Vector(value: 0.0, length: size)
			vector[i] = diag
			m.append(vector)
		}
	}
	
	public init(rows:Int, cols:Int, arr:[Double])
	{
		var array = arr
		for _ in 0..<rows{
			let vec = Vector(array: Array(array[0..<cols]))
			
			array = Array(array.dropFirst(cols))
			m.append(vec)
		}
		
	}
	
	public init(rows:Int, cols:Int, num:Double)
	{
		for _ in 0..<rows{
			let vector = Vector(value: num, length: cols)
			m.append(vector)
		}
	}
	
	
	public init(random rows:Int, cols: Int) {
		
		
		let epsilon = 0.12
		for _ in 0..<rows{
			let v = Vector()
			for _ in 0..<cols {
				v.v.append( drand48()*epsilon - epsilon )
			}
			m.append(v)
		}
		
	}
	
	
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
		set(val){
			m[i] = val
		}
	}
	
	
	public subscript(range:Range<Int>)->Matrix
	{
		get{
			let mat = self.copy() as! Matrix
		
			mat.m = Array(mat.T.m[range])
		
			return mat.T
		}
		set(val){
			for i in 0..<self.rows{
				self.m[i][range] = val[i]
				
			}
		}
		
	}
	
	public func sum()->Double{
		return self.m.flatMap({$0.v}).reduce(0,{$0+$1})
	}
	
	
	static public func ^(x:Matrix, r:Double)->Matrix
	{
		let X = x.copy() as! Matrix
		for i in 0..<X.rows {
			X[i] = X[i]^r
		}
		return X
	}
	
	static public func *(l: Matrix, r:Vector)->Vector
	{
		
		var ans = [Double](repeating:0.0, count: l.rows)
		let mat = l.m.flatMap({$0.v})
		vDSP_mmulD(mat, 1, r.v.flatMap({$0}), 1, &ans, 1, UInt(l.rows), 1, UInt(r.length))
		let vec = Vector(array: ans)
		return vec
	}
	
	
	static public func *(l: Matrix, r:Matrix)->Matrix
	{
		let lMat = l.m.flatMap({$0.v})
		let rMat = r.m.flatMap({$0.v})
		var ansArr = [Double](repeating:0.0, count: l.rows*r.cols)
		
		
		
		
		vDSP_mmulD(lMat, 1, rMat, 1, &ansArr, 1, vDSP_Length(l.rows),vDSP_Length(r.cols),vDSP_Length(r.rows))
		
		
		
		return Matrix(rows: l.rows, cols: r.cols, arr: ansArr)
	}
	
	
	
	
	static public func .*(l:Matrix, r:Matrix)->Matrix
	{
		let ans = l.copy() as! Matrix
		for i in 0..<ans.rows{
			for j in 0..<ans.cols{
				ans[i,j] *= r[i,j]
			}
		}
		return ans
	}
	
	
	
	
	public func transpose(m: Matrix) -> Matrix {
		
		let newMat = Matrix()
		
		for i in 0..<m.cols{
			let v = Vector()
			for j in 0..<m.rows{
				v.append(a: m[j,i])
			}
			newMat.m.append(v)
		}
		
		return newMat
	}
	
	static public prefix func -(mat: Matrix)->Matrix
	{
		let m = mat.copy() as! Matrix
		m.m = m.m.map({-$0})
		return m
	}
	
	static public func +(l:Matrix, r:Matrix)->Matrix{
		let ans = l
		for i in 0..<l.rows{
			for j in 0..<l.cols{
				ans[i,j] += r[i,j]
			}
		}
		return ans
	}
	
	static public func -(l:Matrix, r:Matrix)->Matrix{
		let ans = l.copy() as! Matrix
		for i in 0..<l.rows{
			for j in 0..<l.cols{
				ans[i,j] -= r[i,j]
			}
		}
		return ans
	}
	
	static public func +(l:Matrix, r:Double)->Matrix{
		let ans = l.copy() as! Matrix
		
		for i in 0..<ans.rows{
			for j in 0..<ans.cols{
				ans[i,j] += r
			}
		}
		return ans
	}
	
	static public func -(l:Double, r:Matrix)->Matrix{
		let ans = r.copy() as! Matrix
		
		for i in 0..<ans.rows{
			for j in 0..<ans.cols{
				ans[i,j] = 1 - ans[i,j]
			}
		}
		return ans
	}
	
	static public func *(x:Double, r:Matrix)->Matrix{
		let ans = r
		for i in 0..<r.rows{
			for j in 0..<r.cols{
				ans.m[i].v[j] *= Double(x)
			}
		}
		return ans
	}
	
	static public func /(l:Matrix, r:Double)->Matrix{
		let ans = l.copy() as! Matrix
		for i in 0..<ans.rows{
			for j in 0..<ans.cols{
				ans[i,j] /= r
			}
		}
		return ans
	}
	
	
	
	public func copy(with zone: NSZone? = nil) -> Any {
		let copy = Matrix()
		for i in 0..<self.rows{
			let v = self[i].copy()
			copy.m.append(v as! Vector)
		}
		
		return copy
	}
	
	public var description: String {
		return "\(self.shape)"
//		return self.m.map({$0.description}).reduce("[", {$0+"\n"+$1}) + "\n]"
	}
	
	
	public func prepend(a:Double) -> Matrix{
		
		let mat = self.copy() as! Matrix
		
		for i in mat.m {
			i.v.insert(1, at: 0)
		}
		
		return mat
	}
	
}

