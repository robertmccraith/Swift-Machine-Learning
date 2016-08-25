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



public func readFile(fileName:String)->(X:Matrix, y:Vector)
{
	let filePath = Bundle.main.path(forResource: fileName, ofType: "txt")
	let contentData = FileManager.default.contents(atPath: filePath!)
	let inString = NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as? String
	
	let split = inString?.components(separatedBy: "\n")
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
