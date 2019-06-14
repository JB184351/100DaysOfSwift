import UIKit

class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)

// If you want to prevent someone from changing the value of a variable in your class make it constant like so

/*
 class Singer {
    let name = "Taylor Swift"
 }
*/
