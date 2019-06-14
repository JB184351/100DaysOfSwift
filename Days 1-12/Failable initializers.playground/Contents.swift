import UIKit

let str = "S"
let num = Int(str)

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 0 {
            self.id = id
        }
        else {
            return nil
        }
    }
}


