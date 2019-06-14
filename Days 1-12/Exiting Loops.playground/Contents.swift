import UIKit

var countDown = 10

while countDown >= 10 {
    print(countDown)
    
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    countDown -= 1
}

print("Blast OFF")


