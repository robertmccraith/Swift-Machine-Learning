//: Playground - noun: a place where people can play

import Cocoa




var file = readFile(fileName: "ex1data1")
var X = file.X
var y = file.y


X = X.prepend(a: 1)



var theta = Vector(value: 0.0, length: X.cols)
var iterations = 1500
var alpha = 0.01



var results = gradientDescent(X: X, y: y, thet: theta, alpha: alpha, iterations: iterations)
print(results.theta)







file = readFile(fileName: "ex1data2")
X = file.X
y = file.y

var normalized = featureNormalize(mat: X)
X = normalized.X_norm
X = X.prepend(a: 1.0)
theta = Vector(value: 0.0, length: X.cols)
iterations = 400
alpha = 0.01



results = gradientDescent(X: X, y: y, thet: theta, alpha: alpha, iterations: iterations)
print(results.theta)
