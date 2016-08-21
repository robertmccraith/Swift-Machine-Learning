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
	
	J = -y*logV(v: hypothesis)-(1-y)*logV(v: 1-hypothesis)
	
	return J/Double(X.size.h)
}


public func gradient(theta: Vector, X: Matrix, y:Vector)->Vector
{
	
	let g = X.T*(sigmoid(v: X*theta)-y)
	
	return (1/Double(y.length))*g
}




public func gdbt(t:Vector, X:Matrix, y:Vector, maxIter:Int, threshold:Double, alpha: Double, beta:Double) -> Vector{
	var theta = t
	
	for _ in 0..<maxIter{
		
		let grad = gradient(theta: theta, X: X, y: y)
		let delta = -grad
		
		if grad * grad < threshold {
			return theta
		}
		
		let J = cost(theta: theta, X: X, y: y)
		let alphaGradDelta = alpha*grad*delta
		
		
		var t = 1.0
		
		while cost(theta: theta+t*delta, X: X, y: y) > J+t*alphaGradDelta {
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




