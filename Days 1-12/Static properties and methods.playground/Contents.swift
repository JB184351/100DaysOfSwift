import UIKit

struct Student {
    static var classSize = 0
    var name: String
    
    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}

let ed = Student(name: "Ed")
let tyalor = Student(name: "Taylor")

print(Student.classSize)
