import Foundation


public func normalize(theta:Vector, avg:Vector, sigma:Vector)->Vector
{
	var theta0 = theta[0]
	let vec = Vector(array: theta.v.filter({theta.v.index(of: $0) != 0}))
	for i in 0..<theta.length-1{
		theta0 -= vec[i] * avg[i] / sigma[i]
	}
	theta[0] = theta0
	
	for i in 1..<theta.length{
		theta[i] = theta[i]/sigma[i-1]
	}
	
	return theta
}


public func predict(X:Matrix, theta:Vector)->Vector
{
	let vec = X*theta
	
	vec.v = vec.v.map({ round(sigmoid(z: $0)) })
	
	return vec
	
}


public func mapFeature(X1:Vector, X2:Vector, degree:Int)->Matrix
{
	let out = Matrix(rows: X1.length, cols: 1, num: 1.0)
	for i in 1...degree{
		for j in 0...i{
			let product = (X1^Double(i-j)).mult(r:(X2^Double(j)))
			for k in 0..<X1.length{
				out[k].append(a: product[k])
			}
		}
	}
	
	return out
}
