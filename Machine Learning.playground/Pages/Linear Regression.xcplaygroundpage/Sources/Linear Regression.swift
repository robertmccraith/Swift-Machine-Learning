import Foundation

/**
Gradient Descent Algorithm
- parameter X: matrix of values
- parameter y: vector of target values
- parameter theta: initial hypothesis values
- parameter alpha: size of steps in each iteration
- parameter iterations: number of iterations of gradient descend to run

- returns: 
	 theta: hypothesis values after gradient descent
	 jHistory: history of costs at each iteration


*/

public func gradientDescent(X:Matrix, y:Vector, theta:Vector, alpha:Double, iterations:Int)->(theta:Vector, jHistory:[Double]){
    
    var t = theta
    var jHistory:[Double] = []
    for _ in 0..<iterations {
        
        let predictions = X * theta
        let updates =  X.T * ( predictions - y)
        
        
        t = t - alpha * (1/Double(y.length)) * updates
        
        
        jHistory.append(cost(theta: theta, X: X, y: y))
    }
    
    
    return (t,jHistory)
}

public func cost(theta:Vector, X:Matrix, y:Vector)->Double{
    let m = y.length
    
	
    let prediction = X * theta

	
    let error = prediction - y
    let sum = error.v.reduce(0, { $0 + pow($1, 2)})
    
    
    let J = (1/(2*Double(m))) * sum
    
    return J
}
