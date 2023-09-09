//
//  CalculatorLogic.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import Foundation

struct CalculatorLogic {
    var inputline: String?
    var theResult: Double?
    
    mutating func setline(_ inputline: String) {
        var line = inputline
//        print(line)
        let rpn = convertToRPN(&line)
        theResult = evaluateRPN(rpn)
    }
    
    func convertToRPN(_ line: inout String) -> [String] {
        let prioritiesDictionary: [String:Int] = ["+": 1, "-": 1, "×": 2, "÷": 2, "(": 3, ")": 3]
        var currentOperator = String()
        var operationsStack = [String]()
        var outputStack = [String]()
        var numberString = String()
        var dumpStack = [String]()

        func getPriority(forOperator operatorSymbol: String) -> Int? {
            return prioritiesDictionary[operatorSymbol]
        }
        
        while !line.isEmpty {
            let char = line.removeFirst()
            
            switch char {
            case "0"..."9":
                numberString.append(char)
                
            case ".":
                numberString.append(char)
                
            case "+", "-", "×", "/":
                if !numberString.isEmpty {
                    outputStack.append(numberString)
                    numberString = String()
                }

                currentOperator = String(char)
                if !operationsStack.isEmpty {
                    if let previousOpPriority = getPriority(forOperator: operationsStack.last!) {
                        if let currentOpPriority = getPriority(forOperator: currentOperator) {
                            if currentOpPriority <=  previousOpPriority  {
                                if previousOpPriority == 3 {
    // print("there's the comparison which involves ( or ), so operationsStack is", operationsStack)
                                    operationsStack.append(currentOperator)
                                     continue
                                } else {
                                    let operation = operationsStack.removeLast()
                                    outputStack.append(operation)
                                }
                            }
                        }
                    }
                }
                operationsStack.append(currentOperator)
            case "(":
                operationsStack.append(String(char))
                
            case ")":
                if !numberString.isEmpty {
                    outputStack.append(numberString)
                    numberString = String()
                }

                    while operationsStack.last != "(" {
                        outputStack.append(operationsStack.removeLast())
                    }

                    if operationsStack.last == "(" {
                        dumpStack.append(operationsStack.removeLast())
                    }
                
            default:
                continue
            }
        }
        
        if !numberString.isEmpty {
            outputStack.append(numberString)
        }
        
        while !operationsStack.isEmpty {
            let operation = operationsStack.removeLast()
            if operation != "(" {
                outputStack.append(operation)
            } else {
                dumpStack.append(operation)
            }
        }
        return outputStack
    }

    func evaluateRPN(_ line: [String]) -> Double {
        var numbersStack = [Double]()
        
        for i in line {
            if let number = Double(i) {
                numbersStack.append(number)
            } else {
                if numbersStack.count >= 2 {
                    let operand2 = numbersStack.removeLast()
                    let operand1 = numbersStack.removeLast()
                    if i == "+" {
                        numbersStack.append(operand1 + operand2)
                    } else if i == "-" {
                        numbersStack.append(operand1 - operand2)
                    } else if i == "×" {
                        numbersStack.append(operand1 * operand2)
                    } else if i == "÷" {
                        numbersStack.append(operand1 / operand2)
                    }
                }
            }
        }
        return numbersStack.first ?? 0.0
    }
}
