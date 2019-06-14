import UIKit

class Singer {
    var name = "Taylor Swift"
}

var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bengtson"

// Because of the way classes work, both singer and singerCopy point to the same object in memory, so when we print the singer name again we'll see the latest change in the variable and in this instance we will see "Justin Bengtson" printed.
print(singer.name)

// On the other hand, if Singer were a struct then we would get "Taylor Swift" printed a second time:
/*
struct Singer {
    var name = "Taylor Swift"
}
*/
