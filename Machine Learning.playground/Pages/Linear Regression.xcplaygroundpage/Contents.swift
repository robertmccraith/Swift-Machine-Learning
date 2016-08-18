//: Playground - noun: a place where people can play

import Cocoa




let file = "ex1data2.txt" //this is the file. we will write to and read from it

let downloadDirectory = try! FileManager.default.url(for: .adminApplicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
var fileURL = downloadDirectory.appendingPathComponent(file)

let filePath = Bundle.main.path(forResource: "ex1data2", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let inString = NSString(data: contentData!, encoding: String.Encoding.utf8.rawValue) as? String




let split = inString?.components(separatedBy: "\n")


var input = (split!.map({$0.components(separatedBy:",")}))


var X:Matrix = Matrix()

var y:Vector = Vector()


for i in input {
    
    var data = i.map({Double($0)!})
    
    y.append(a: data.removeLast())
    
    X.m.append(Vector(array: data))
    
    
}


var normalized = featureNormalize(mat: X)
X = normalized.X_norm
X = X.prepend(a: 1)



var theta = Vector(value: 0.0, length: X.size.w)
let iterations = 400
let alpha = 0.01



var results = gradientDescent(X: X, y: y, thet: theta, alpha: alpha, iterations: iterations)
print(results.theta)
