import UIKit

func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)

func countMultiplesOf10(numbers: [Int]) -> Int {
    var result = 0
    for number in numbers {
        if number % 10 == 0 {
            result += 1
        }
    }
    return result
}
countMultiplesOf10(numbers: [5, 10, 15, 20, 25])
