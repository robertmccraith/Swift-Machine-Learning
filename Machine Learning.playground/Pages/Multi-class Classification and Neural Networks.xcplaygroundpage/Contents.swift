
import Foundation
import Accelerate

/*
var m1 = [3.0, 2.0, 4.0, 5.0, 6.0, 7.0]
var m2 = [ 10.0, 20.0, 30.0, 30.0, 40.0, 50.0]
var mresult = [Double](repeating : 0.0, count : 9)

vDSP_mmulD(m1, 1, m2, 1, &mresult, 1, 3, 3, 2)


//print(Matrix(rows: 3, cols: 3, arr: mresult))



var lMat = Matrix(rows: 3, cols: 2, arr: m1)
var rMat = Matrix(rows: 2, cols: 3, arr: m2)

lMat*rMat
*/



var X = readMat(fileName: "X2")
let y = readMat(fileName: "y").T[0]


let thetas = oneVsAll(x: X, y: y, num_labels: 10, lambda: 0.1)
let pred = predictOneVsAll(thetas: thetas, x: X)

var precision = 0

for i in 0..<y.length{
	if y[i] == pred[i] {
		precision += 1
	}
}
print(Double(precision)/Double(y.length))




let theta1 = readMat(fileName: "Theta1")
let theta2 = readMat(fileName: "Theta2")




X = X.prepend(a: 1.0)
let z2 = theta1*X.T

let a2 = sigmoid(mat: z2).T.prepend(a: 1.0)
let z3 = theta2*a2.T

let a3 = sigmoid(mat: z3)

let predict = Vector(value: 0.0, length: a3.cols)

let a3T = a3.T
for i in 0..<a3.cols{
	for j in 0..<a3.rows{
		if a3[j,i] == a3T[i].v.max(){
			predict[i] = Double(j)+1
		}
	}
}


precision = 0
predict.length
for i in 0..<y.length{
	if y[i] == predict[i] {
		precision += 1
	}
}
print(Double(precision)/Double(y.length))
