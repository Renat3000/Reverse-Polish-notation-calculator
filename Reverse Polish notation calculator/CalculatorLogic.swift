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
        highestPrioritySymbolStep = -1
        highestPrioritySymbol = ""
        highestPriority = 0
        
        for (index, symbol) in operationsStack.enumerated() {
            if let priority = prioritiesDictionary[symbol], priority > highestPriority {
                highestPrioritySymbolStep = index
                highestPrioritySymbol = symbol
                highestPriority = priority
            }
        }
        return highestPrioritySymbolStep
    }

    
    mutating func calculate(numbersStack: [String], operationsStack: [String]) -> Double {
//        var numStack = numbersStack
//        var opStack = operationsStack
        var result = 0.0
        
        while numbersStack.count > 1 {
            print("current numbersStack:", self.numbersStack)
            print("current operationsStack:",self.operationsStack)
            
            let currentstep = currentHighestSymbolStep()
            if self.operationsStack.count == 1 {
                let operation = self.operationsStack.removeLast()
                let n2 = Double(self.numbersStack.remove(at: 1))
                let n1 = Double(self.numbersStack.remove(at: 0))
                currentCalculation = IntermediateCalculation(firstNumber: n1!, operation: operation)
                result = performTwoNumbersOperation(secondNumber: n2!)
                return Double(result)
            } else {
                let operation = self.operationsStack.remove(at: currentstep)
                let n2 = Double(self.numbersStack.remove(at: currentstep + 1))
                let n1 = Double(self.numbersStack.remove(at: currentstep))
                currentCalculation = IntermediateCalculation(firstNumber: n1!, operation: operation)
                result = performTwoNumbersOperation(secondNumber: n2!)
                self.numbersStack.insert(String(result), at: currentstep)
            }
        }
        
        return result
    }

}
