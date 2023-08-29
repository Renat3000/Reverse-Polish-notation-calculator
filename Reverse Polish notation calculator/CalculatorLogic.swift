//
//  CalculatorLogic.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import Foundation

struct CalculatorLogic {
    var inputline: String?
//    var numbersStack = stackForNumbers()
//    var operationsStack = stackForOperations()
    var numbersStack = [String]()
    var operationsStack = [String]()
    var operations = "+-×÷="
    var prioritiesDictionary: [String:Int] = ["+":1,"-":1,"×":2,"÷":2]
    var currentNumber = ""
    var theResult: Double?

    mutating func setline(_ inputline: String) {
        self.inputline = inputline
        print("tis nothing but a \(inputline)")
        for char in inputline {
                if !operations.contains(char) {
                    currentNumber.append(char)
                } else {
                    numbersStack.append(currentNumber)
                    currentNumber = ""
                    operationsStack.append(String(char))
                }
            }
        print(numbersStack)
        print(operationsStack)
        operationsStack.removeLast() // delete the "="
        theResult = calculate(numbersStack: numbersStack, operationsStack: operationsStack)
        numbersStack.removeAll()
        operationsStack.removeAll()
    }
    
    struct IntermediateCalculation {
        let firstNumber: Double
        let operation: String
    }
    var currentCalculation: IntermediateCalculation?
    
    mutating func performTwoNumbersOperation(secondNumber: Double) -> Double {
        if let calculation = currentCalculation {
            let firstNumber = calculation.firstNumber
            let operation = calculation.operation
            
            switch operation {
            case "+": return firstNumber + secondNumber
            case "-": return firstNumber - secondNumber
            case "×": return firstNumber * secondNumber
            case "÷": return firstNumber / secondNumber
            default: fatalError("Invalid operation: \(operation)")
            }
        }
        return 0
    }
    
    mutating func calculate(numbersStack: [String], operationsStack: [String]) -> Double {
        var numbersStack = numbersStack // Create a mutable copy
        var operationsStack = operationsStack // Create a mutable copy
        var result = Double(numbersStack.removeFirst()) ?? 0 // Initialize result with a default value
        while !numbersStack.isEmpty {
                let operation = operationsStack.removeFirst()
                currentCalculation = IntermediateCalculation(firstNumber: result, operation: operation)
                if let secondNumber = Double(numbersStack.removeFirst()) {
                    result = performTwoNumbersOperation(secondNumber: secondNumber)
            }
        }
        
        return result
    }

}
