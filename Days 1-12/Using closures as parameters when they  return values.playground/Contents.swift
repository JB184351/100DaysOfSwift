import UIKit

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("london")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
