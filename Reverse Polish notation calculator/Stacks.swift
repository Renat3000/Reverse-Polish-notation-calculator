//
//  Stack.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import Foundation

struct stackForNumbers {
    var items = [Double]()
    mutating func push(_ item: Double) {
        items.append(item)
    }
    mutating func pop() -> Double {
        return items.removeLast()
    }
}

struct stackForOperations {
    var items = [String]()
    mutating func push(_ item: String) {
        items.append(item)
    }
    mutating func pop() -> String {
        return items.removeLast()
    }
    
}
