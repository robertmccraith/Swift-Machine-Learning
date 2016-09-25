import Foundation

public func oneVsAll(x:Matrix, y:Vector, num_labels:Int, lambda:Double)->Matrix
{
	let X = x.prepend(a: 1)
	let thetas = Matrix(rows: num_labels, cols: X.cols, num: 0.0)
	
	
	for i in 0..<num_labels {
		let initTheta = Vector(value: 0.0, length: X.cols)
		
		var yi:[Double] = []
		yi = y.v.map({ if Int($0) == i+1 {
			return 1
		}else{
			return 0
			}
		})
		let vecY = Vector(array: yi)
		thetas[i] = gdbt(t: initTheta, X: X, y: vecY, maxIter: 100, threshold: 1e-8, alpha: 0.25, beta: 0.5, lambda: lambda)
	}
	
	
	return thetas
}


public func predictOneVsAll(thetas:Matrix, x:Matrix)->Vector
{
	let X =  x.prepend(a: 1)
	
	let hypothesis = X*thetas.T
	
	let y = Vector(value: 0.0, length: x.rows)
	
	for i in 0..<hypothesis.rows{
		for j in 0..<hypothesis.cols{
			if hypothesis[i,j] == hypothesis[i].v.max(){
				y[i] = Double(j)+1
			}
		}
	}
	return y
	
}
