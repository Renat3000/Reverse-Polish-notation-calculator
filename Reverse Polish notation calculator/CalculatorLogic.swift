//
//  CalculatorLogic.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import Foundation

struct CalculatorLogic {
    var inputline: String?
    var numbersStack = [String]()
    var operationsStack = [String]()
    var operations = "+-×÷="
    var prioritiesDictionary: [String:Int] = ["+":1,"-":1,"×":2,"÷":2]
    var currentNumber = ""
    var theResult: Double?
    
    var highestPrioritySymbol: String?
    var highestPriority = 0
    var highestPrioritySymbolStep = 0
    
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
    
    mutating func currentHighestSymbolStep() -> Int {
        if operationsStack.count == 1 {
            highestPrioritySymbolStep = 0
        } else {
            for (index, symbol) in operationsStack.enumerated() {
                if let priority = prioritiesDictionary[symbol], priority > highestPriority {
                    highestPrioritySymbolStep = index
                    highestPrioritySymbol = symbol
                    highestPriority = priority
                }
            }
        }
        return highestPrioritySymbolStep
    }
    
    mutating func calculate(numbersStack: [String], operationsStack: [String]) -> Double {
        var numStack = numbersStack
        var opStack = operationsStack
        var result = 0.0
        
        while numbersStack.count > 1 {
            
            let currentstep = currentHighestSymbolStep()
            if opStack.count == 1 {
                let operation = opStack.removeLast()
                let n2 = Double(numStack.remove(at: 1))
                let n1 = Double(numStack.remove(at: 0))
                currentCalculation = IntermediateCalculation(firstNumber: n1!, operation: operation)
                result = performTwoNumbersOperation(secondNumber: n2!)
                return Double(result)
            } else {
                let operation = opStack.remove(at: currentstep)
                let n2 = Double(numStack.remove(at: currentstep + 1))
                let n1 = Double(numStack.remove(at: currentstep))
                currentCalculation = IntermediateCalculation(firstNumber: n1!, operation: operation)
                result = performTwoNumbersOperation(secondNumber: n2!)
                numStack.append(String(result))
            }
        }
        
        return result
    }

}
