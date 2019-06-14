import UIKit

var name: String? = nil

// Common way of unwrapping optionals is with if let syntax.
if let unwrapped = name {
    print("\(unwrapped.count) letters")
}
else {
    print("Missing name.")
}
