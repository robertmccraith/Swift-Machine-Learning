import Foundation

var file = readFile(fileName: "ex2data1")
var X = file.X
var y = file.y

var norm = featureNormalize(mat: X)
var X_norm = norm.X_norm
X_norm = X_norm.prepend(a: 1)
X = X.prepend(a: 1)



var theta = Vector(value: 0.0, length: X.size.w)

theta = gdbt(t: theta, X: X_norm, y: y, maxIter: 1000, threshold: 1e-8, alpha: 0.01, beta: 0.8, lambda: 0)

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




file = readFile(fileName: "ex2data2")
X = file.X
y = file.y
X = mapFeature(X1: X.T[0], X2: X.T[1], degree: 6)

theta = Vector(value: 0.0, length: X.size.w)

let lambda = 1.0

costReg(theta: theta, X: X, y: y, lambda: lambda)

theta = gdbt(t: theta, X: X, y: y, maxIter: 400, threshold: 1e-8, alpha: 0.01, beta: 0.8, lambda: lambda)


p = predict(X: X, theta: theta)


accuracy = Double(X.size.h)
for i in 0..<y.length{
	accuracy -= abs(y[i]-p[i])
}
print("Train accuracy: \(100*accuracy/Double(y.length))%")
