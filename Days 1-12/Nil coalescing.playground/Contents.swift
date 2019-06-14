import UIKit

func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    }
    else {
        return nil
    }
}

// With this if the username function were to return nil then user would be set to Anonymous
let user = username(for: 15) ?? "Anonymous"
