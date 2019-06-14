import UIKit

let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation", "Night Visions", "Smoke and Mirrors", "Evolve", "Origins"]

for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna" )

// Underscore so we don't have to create a variable we don't need
for _ in 1...5 {
    print("play")
}
