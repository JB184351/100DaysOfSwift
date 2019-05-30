import UIKit

struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
    
}

var progreess = Progress(task: "Loading Data", amount: 0)
progreess.amount = 30
progreess.amount = 80
progreess.amount = 100

