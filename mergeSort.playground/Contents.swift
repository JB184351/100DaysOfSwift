import UIKit

func mergeSort(array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }
    
    let leftArray: [Int] = Array(array[0..<array.count/2])
    let rightArray: [Int] = Array(array[array.count/2..<array.count])
    
    return merge(left: mergeSort(array: leftArray), right: mergeSort(array: rightArray))
}

func merge(left: [Int], right: [Int]) -> [Int] {
    
    var mergeArray: [Int] = []
    var left = left
    var right = right
    
    while left.count > 0 && right.count > 0 {
        if left.first! < right.first! {
            mergeArray.append(left.removeFirst())
        }
        else {
            mergeArray.append(right.removeFirst())
        }
    }
    
    
    
    return mergeArray + left + right
}

var numbers: [Int] = []

for _ in 0..<50 {
    let randomInt = Int(arc4random_uniform(UInt32(1000)))
    numbers.append(randomInt)
}
 

print(numbers)
print()
print(mergeSort(array: numbers))
