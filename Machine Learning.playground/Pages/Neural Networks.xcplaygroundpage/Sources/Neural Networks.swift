import Foundation

public func nncost(Theta1:Matrix, Theta2:Matrix, inputLayer:Int, hiddenLayer:Int, numLabels:Int, X:Matrix, y:Vector, lambda:Double)->Double
{
	var J = 0.0
	
	let X = X.prepend(a: 1.0)
	
	
	let Y = Matrix(rows: X.rows, cols: numLabels, num: 0)
	
	for i in 0..<numLabels{
		for j in 0..<X.rows{
			if Int(y[j]) == i+1 {
				Y[j,i%10] = 1
				
			}
		}
	}
	
	
	//Calculate Activations at each layer, add bias in second layer after sigmoid applied
	
	let a2 = sigmoid(mat: X*Theta1.T).prepend(a: 1.0)
	let a3 = sigmoid(mat: a2*Theta2.T)
	
	
	let left = (-Y).*logM(mat: a3)
	
	let right = (1-Y).*logM(mat: 1-a3)
	
	J = (left - right).sum()/Double(X.rows)
	
	J += lambda*((Theta1[1..<Theta1.cols]^2).sum()+(Theta2[1..<Theta2.cols]^2).sum())/Double(X.rows)/2.0
	
	return J
}


public func nncGradient(Theta1:Matrix, Theta2:Matrix, inputLayer:Int, hiddenLayer:Int, numLabels:Int, X:Matrix, y:Vector, lambda:Double)->(Theta1Grad: Matrix, Theta2Grad:Matrix)
{
	
	var Delta1 = Matrix(rows: hiddenLayer, cols: inputLayer+1, num: 0.0)
	var Delta2 = Matrix(rows: numLabels, cols: hiddenLayer+1, num: 0.0)
	
	for i in 0..<X.rows{
		let a1 = X[i].copy() as! Vector
		a1.v.insert(1.0, at: 0)
		
		let z2 = Theta1*a1
		let a2 = sigmoid(v: z2)
		a2.v.insert(1.0, at: 0)
		let z3 = Theta2*a2
		let a3 = sigmoid(v: z3)
		
		
		
		let yvec = Vector(value: 0.0, length: numLabels)
		yvec[Int(y[i])-1] = 1
		let delta3 = a3-yvec
		
		
		var delta2 = (Theta2.T*delta3).*(r: sigmoidGradient(z: z2).insert(a: 1.0, at: 0))
		
		
		delta2 = delta2[1..<delta2.length]
		
		Delta2 = Delta2 + delta3.col * a2.row
		
		Delta1 = Delta1 + delta2.col * a1.row

		
	}
	
	//print(Delta1, Delta2)
	
	let Theta1Grad = Delta1/Double(X.rows)
	let Theta2Grad = Delta2/Double(X.rows)
	
	Theta1Grad[1..<Theta1Grad.cols] = Theta1Grad[1..<Theta1Grad.cols] + (lambda/Double(X.rows))*Theta1Grad[1..<Theta1Grad.cols]
	
	Theta2Grad[1..<Theta2Grad.cols] = Theta2Grad[1..<Theta2Grad.cols] + (lambda/Double(X.rows))*Theta2Grad[1..<Theta2Grad.cols]
	
	
	return (Theta1Grad, Theta2Grad)
	
}




public func sigmoidGradient(z:Vector)->Vector
{
	let sigZ = sigmoid(v: z)
	return sigZ.*(r: 1-sigZ)
}
