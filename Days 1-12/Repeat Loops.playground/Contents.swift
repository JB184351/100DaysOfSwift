import UIKit

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print ("Ready or not, here I come!")

var scales = ["A", "B", "C", "D", "E"]
var scaleCounter = 0
repeat {
    print("Play the \(scales[scaleCounter]) scale")
    scaleCounter += 1
} while scaleCounter < 3

/*
// Will never execute
while false {
    print("This is false")
}
 */

repeat {
    print("This is false")
} while false
