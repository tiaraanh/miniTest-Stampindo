import UIKit

var oneHundred = [Int]()

for i in 1...100 {
    oneHundred.append(i)
}

for number in oneHundred {
    if number % 3 == 0 && number % 5 == 0 {
        print("ApaBole", terminator: ", ")
    } else if number % 3 == 0 {
        print("Apa", terminator: ", ")
    } else if number % 5 == 0 {
        print("Bole", terminator: ", ")
    } else {
        print("\(number)", terminator: ", ")
    }
}



