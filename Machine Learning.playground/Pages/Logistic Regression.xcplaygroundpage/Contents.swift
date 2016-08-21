import Foundation

let filePath = Bundle.main.path(forResource: "ex2data1", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let inString = NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as? String

let split = inString?.components(separatedBy: "\n")
var input = (split!.filter({$0 != ""}).map({$0.components(separatedBy:",")}))
var X:Matrix = Matrix()
var y:Vector = Vector()


for i in input {
    var data = i.map({Double($0)!})
    y.append(a: data.removeLast())
    X.m.append(Vector(array: data))
}


var norm = featureNormalize(mat: X)
var X_norm = norm.X_norm
X_norm = X_norm.prepend(a: 1)
X = X.prepend(a: 1)

var theta = Vector(value: 0.0, length: 3)

theta = gdbt(t: theta, X: X_norm, y: y, maxIter: 1000, threshold: 1e-8, alpha: 0.01, beta: 0.8)

cost(theta: theta, X: X_norm, y: y)

var vec = Vector(array: theta.v.filter({theta.v.index(of: $0) != 0}))

//convert the values from normalized into original scale
theta = normalize(theta: theta, avg: Vector(array:norm.avg), sigma: Vector(array: norm.sigma))

//predict result 45 in first, 85 in second
sigmoid(z:Vector(array: [1, 45, 85])*theta)


var p = predict(X: X, theta: theta)

var accuracy = 100.0
for i in 0..<y.length{
	accuracy -= abs(y[i]-p[i])
}
print("Train accuracy: \(100*accuracy/Double(y.length))%")
