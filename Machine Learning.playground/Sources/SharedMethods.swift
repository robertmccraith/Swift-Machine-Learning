import Foundation

public func featureNormalize(mat: Matrix)->(X_norm:Matrix, avg:[Double], sigma:[Double]){
	let matTRan = mat.T
	var avgs:[Double] = []
	var stdDevs:[Double] = []
	
	for i in 0..<matTRan.rows{
		
		let a  = matTRan[i]
		
		let len = Double(a.length)
		
		let avg = a.v.reduce(0, {$0+$1})/len
		avgs.append(avg)
		
		let sumSquares = a.v.map({pow($0-avg, 2)}).reduce(0, {$0+$1})
		let stdDev = sqrt(sumSquares/(len-1))
		stdDevs.append(stdDev)
		
		for j in 0..<a.length {
			a[j] = (a[j]-avg)/stdDev
		}
		
		
		
	}
	return (matTRan.T,avgs,stdDevs)
}



public func readFile(fileName:String)->(X:Matrix, y:Vector)
{
	let filePath = Bundle.main.path(forResource: fileName, ofType: "txt")
	let contentData = FileManager.default.contents(atPath: filePath!)
	let inString = NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as? String
	
	let split = inString?.replacingOccurrences(of: "\r", with: "") .components(separatedBy: "\n")
	let input = (split!.filter({$0 != ""}).map({$0.components(separatedBy:",")}))
	
	let X:Matrix = Matrix()
	let y:Vector = Vector()
	
	
	for i in input {
		var data = i.map({Double($0)!})
		y.append(a: data.removeLast())
		X.m.append(Vector(array: data))
	}
	
	return (X,y)
}


public func readMat(fileName:String)->Matrix
{
	let filePath = Bundle.main.path(forResource: fileName, ofType: "csv")
	let contentData = FileManager.default.contents(atPath: filePath!)
	let inString = (NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as? String)?.replacingOccurrences(of: "\r", with: "")
	
	let split = inString?.components(separatedBy: "\n")
	let input = (split!.filter({$0 != ""}).map({$0.components(separatedBy:",")}))
	let X:Matrix = Matrix()

	for i in input {
		let data = i.map({Double($0)!})
		X.m.append(Vector(array: data))
	}
	return X
}

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

public func sigmoid(mat:Matrix)->Matrix
{
	let m = Matrix(rows: mat.rows, cols: mat.cols, num: 0.0)
	for i in 0..<mat.rows{
		m[i] = sigmoid(v: mat[i])
	}
	return m
}


public func logV(v:Vector)->Vector
{
	let vec = Vector(array: v.v)
	vec.v = vec.v.map({ Darwin.log($0)  })
	return vec
}


public func logM(mat:Matrix)->Matrix
{
	let m = mat.copy() as! Matrix
	m.m = m.m.map({logV(v: $0)})
	
	return m
}


public func cost(theta: Vector, X: Matrix, y:Vector)->Double
{
	var J = 0.0
	let hypothesis = sigmoid(v: X*theta)
	let m = Double(X.rows)
	J = (-y*logV(v: hypothesis)-(1-y)*logV(v: 1-hypothesis))/m
	
	return J
}


public func gradient(theta: Vector, X: Matrix, y:Vector)->Vector
{
	
	let g = (1/Double(y.length)) * X.T*(sigmoid(v: X*theta)-y)
	
	return g
}


public func costReg(theta: Vector, X: Matrix, y:Vector, lambda:Double)->Double
{
	let m = Double(X.rows)
	var J = cost(theta: theta, X: X, y: y)
	let t = theta.copy() as! Vector
	if lambda == 0.0 {
		t.v.removeFirst()
	}
	
	J += lambda/(2*m) * t.v.reduce(0, {$0+pow($1, 2)})
	
	return J
}

public func gradientReg(theta: Vector, X: Matrix, y:Vector, lambda:Double)->Vector
{
	
	let sigHypot = sigmoid(v: X*theta)
	
	let grad = Vector()
	
	let xT = X.T
	
	grad.append(a: xT[0]*(sigHypot-y))
	
	for i in 1..<X.cols{
		grad.append(a: xT[i]*(sigHypot-y) + lambda*theta[i])
	}
	return grad/Double(y.length)
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
	
	print("cost", costReg(theta: theta, X: X, y: y, lambda: lambda))
	return theta
}



