//  Created by Renat Nazyrov on 05.09.2023.
//

import Foundation

var line = "20*((5+3)/4)"    // the answer is: 2 5 3 + 4 / *
var line2 = "(((3+3*2)*0)+10)"
func convertToRPN(_ line: inout String) -> [String] {
    let prioritiesDictionary: [String:Int] = ["+": 1, "-": 1, "*": 2, "/": 2, "(": 3, ")": 3]
    var currentOperator = String()
    var operationsStack = [String]()
    var outputStack = [String]()
    var numberString = String()
    var dumpStack = [String]()
    var result = [String]()
    
    func getPriority(forOperator operatorSymbol: String) -> Int? {
        return prioritiesDictionary[operatorSymbol]
    }
    
    while !line.isEmpty {
        let char = line.removeFirst()
        
        switch char {
        case "0"..."9":
            numberString.append(char)

        case "+", "-", "*", "/":
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
//  print("there's the comparison which involves "(" or ")", so operationsStack is", operationsStack)
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
// If the token is a closing bracket:
// - Pop operators off the stack and append them to the output, until the operator at the top of the stack is a opening bracket.
            
                while operationsStack.last != "(" {
                    outputStack.append(operationsStack.removeLast())
                }
// - Pop the opening bracket off the stack.
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
    result = outputStack
    return result
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
                } else if i == "*" {
                    numbersStack.append(operand1 * operand2)
                } else if i == "/" {
                    numbersStack.append(operand1 / operand2)
                }
            }
        }
    }
    return numbersStack.first ?? 0.0
}

var LineRPNStack = convertToRPN(&line)
evaluateRPN(LineRPNStack)
