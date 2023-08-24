//
//  CalculatorLogic.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import Foundation

struct CalculatorLogic {
    var number: Double?
    var numbersStack = stackForNumbers ()
    var operationsStack = stackForOperations ()
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        var prioritiesDictionary: [String:Int] = ["+":1,"-":1,"×":2,"÷":2]
            return nil
    }
    
}
