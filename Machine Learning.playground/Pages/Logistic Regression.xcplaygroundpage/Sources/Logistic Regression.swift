import Foundation




public func sigmoid(z:Double)->Double{
	return 1/(1+exp(-z))
}

public func sigmoid(v:Vector)->Vector
{
	let vec = Vector(value: 0.0, length: v.length)
	for i in 0..<v.length{
		vec[i] = sigmoid(z: v[i])
	}
	return vec
}

public func logV(v:Vector)->Vector
{
	let vec = Vector(array: v.v)
	vec.v = vec.v.map({ Darwin.log($0)  })
	return vec
}


public func cost(theta: Vector, X: Matrix, y:Vector)->Double
{
	var J = 0.0
	let hypothesis = sigmoid(v: X*theta)
	let m = Double(X.size.h)
	J = (-y*logV(v: hypothesis)-(1-y)*logV(v: 1-hypothesis))/m
	
	return J
}


public func gradient(theta: Vector, X: Matrix, y:Vector)->Vector
{
	
	let g = (1/Double(y.length)) * X.T*(sigmoid(v: X*theta)-y)
	
	return g
}




public func gdbt(t:Vector, X:Matrix, y:Vector, maxIter:Int, threshold:Double, alpha: Double, beta:Double, lambda:Double) -> Vector{
	var theta = t
	
	for _ in 0..<maxIter{
		
		let grad = gradientReg(theta: theta, X: X, y: y, lambda: lambda)
		let delta = -grad
		
		if grad * grad < threshold {
			return theta
		}
		
		let J = costReg(theta: theta, X: X, y: y, lambda:lambda)
		let alphaGradDelta = alpha*grad*delta
		
		
		var t = 1.0
		
		while costReg(theta: theta+t*delta, X: X, y: y, lambda:lambda) > J+t*alphaGradDelta {
			t = beta*t
		}
		
		theta = theta+t*delta
		
	}
	return theta
}

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
	let out = Matrix(h: X1.length, w: 1, num: 1.0)
	
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

public func costReg(theta: Vector, X: Matrix, y:Vector, lambda:Double)->Double
{
	let m = Double(X.size.h)
	
	let J = cost(theta: theta, X: X, y: y) + lambda/(2*m) * theta.v.reduce(0, {$0+pow($1, 2)})
	
	return J
}

public func gradientReg(theta: Vector, X: Matrix, y:Vector, lambda:Double)->Vector
{
	let m = Double(X.size.h)
	
	let g = gradient(theta: theta, X: X, y: y) + lambda/m * theta
	
	return g
}





