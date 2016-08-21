import Foundation

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

