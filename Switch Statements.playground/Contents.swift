import UIKit

let weather = "sunny"

switch weather {
case "rain":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day")
}
