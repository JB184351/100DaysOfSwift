import UIKit

var toys = ["Woody"]

print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz")
print(toys.sorted())
toys.remove(at: 0)

var examScores = [100, 95, 92]
examScores.insert(98)
