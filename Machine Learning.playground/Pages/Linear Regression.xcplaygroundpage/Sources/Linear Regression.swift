import Foundation

public func gradientDescent(X:Matrix, y:Vector, thet:Vector, alpha:Double, iterations:Int)->(theta:Vector, jHistory:[Double]){
    
    var theta = thet
    var jHistory:[Double] = []
    for _ in 0..<iterations {
        
        let predictions = X * theta
        let updates =  X.T * ( predictions - y)
        
        
        theta = theta - alpha * (1/Double(y.length)) * updates
        
        
        jHistory.append(cost(theta: theta, X: X, y: y))
    }
    
    
    return (theta,jHistory)
}

public func cost(theta:Vector, X:Matrix, y:Vector)->Double{
    let m = y.length
    
    
    let prediction = X * theta
    let error = prediction - y
    let sum = error.v.reduce(0, { $0 + pow($1, 2)})
    
    
    let J = (1/(2*Double(m))) * sum
    
    return J
}

public func featureNormalize(mat: Matrix)->(X_norm:Matrix, avg:[Double], sigma:[Double]){
    let matTRan = mat.T
    var avgs:[Double] = []
    var stdDevs:[Double] = []
    
    for i in 0..<matTRan.size.h{
        
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
