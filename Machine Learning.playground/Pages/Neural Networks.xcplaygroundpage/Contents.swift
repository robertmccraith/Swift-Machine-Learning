//: [Previous](@previous)

import Foundation


let X = readMat(fileName: "X")
let y = readMat(fileName: "y").T[0]
let Theta1 = readMat(fileName: "Theta1")
let Theta2 = readMat(fileName: "Theta2")





let input_layer_size  = 400
let hidden_layer_size = 25
let num_labels = 10
let lambda = 0.0


print(nncGradient(Theta1: Theta1, Theta2: Theta2, inputLayer: input_layer_size, hiddenLayer: hidden_layer_size, numLabels: num_labels, X: X, y: y, lambda: lambda))

nncost(Theta1:Theta1, Theta2:Theta2, inputLayer: input_layer_size, hiddenLayer: hidden_layer_size, numLabels: num_labels, X: X, y: y, lambda:1.0)


let initTheta1 = Matrix(random: input_layer_size, cols: hidden_layer_size)
let initTheta2 = Matrix(random: hidden_layer_size, cols: num_labels)
print(initTheta1.m)
print(initTheta2.m)