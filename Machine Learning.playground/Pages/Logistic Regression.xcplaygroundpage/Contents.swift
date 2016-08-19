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


func sigmoid(z:Double)->Double{
    return 1/(1+exp(-z))
}

func sigmoid(v:Vector)->Vector
{
    let vec = Vector(value: 0.0, length: v.length)
    for i in 0..<v.length{
        vec[i] = sigmoid(z: v[i])
    }
    return vec
}

func logV(v:Vector)->Vector
{
    let vec = Vector(array: v.v)
    vec.v = vec.v.map({ Darwin.log($0)  })
    return vec
}


func cost(theta: Vector, X: Matrix, y:Vector)->Double
{
    var J = 0.0
    let hypothesis = sigmoid(v: X*theta)
    
    J = -y*logV(v: hypothesis)-(1-(-y))*logV(v: 1-hypothesis)
    
    return J/Double(X.size.h)
}


func gradient(theta: Vector, X: Matrix, y:Vector)->Double
{
    let g = (X.T*sigmoid(v: X*theta)-y).v.reduce(0, {$0+$1})
    
    return g/Double(X.size.h)
}

var theta = Vector(value: 0.0, length: 2)
cost(theta: theta, X: X, y: y)


