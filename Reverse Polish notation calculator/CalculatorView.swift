//
//  CalculatorView.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import UIKit

class CalculatorView: UIView {
    
    var outputField: UILabel
    
    init() {
        outputField = createLabel()
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(outputField)
        outputField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        outputField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        outputField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let zeroStack = createStackView()
        let buttonAC = makeButton(withText: "AC")
        let buttonOpeningBracket = makeButton(withText: "(")
        let buttonClosingBracket = makeButton(withText: ")")
        let buttonSign = makeButton(withText: "±")
        let buttonPercentage = makeButton(withText: "%")
        let buttonDivision = makeButton(withText: "÷")
        
        buttonAC.addTarget(self, action: #selector(ViewController.calcButtonPressed(_:)), for: .touchUpInside)
        buttonAC.titleLabel?.adjustsFontSizeToFitWidth = true
//        buttonOpeningBracket.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonClosingBracket.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonSign.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonPercentage.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonDivision.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        zeroStack.addArrangedSubview(buttonAC)
        zeroStack.addArrangedSubview(buttonOpeningBracket)
        zeroStack.addArrangedSubview(buttonClosingBracket)
//        zeroStack.addArrangedSubview(buttonSign)
//        zeroStack.addArrangedSubview(buttonPercentage)
        zeroStack.addArrangedSubview(buttonDivision)
        addSubview(zeroStack)
        
        zeroStack.topAnchor.constraint(equalTo: outputField.bottomAnchor, constant: 8).isActive = true
        zeroStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        zeroStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let firstStack = createStackView()
        let button7 = makeButton(withText: "7")
        let button8 = makeButton(withText: "8")
        let button9 = makeButton(withText: "9")
        let buttonMultiplication = makeButton(withText: "×")
        
//        button7.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button8.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button9.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonMultiplication.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        firstStack.addArrangedSubview(button7)
        firstStack.addArrangedSubview(button8)
        firstStack.addArrangedSubview(button9)
        firstStack.addArrangedSubview(buttonMultiplication)
        addSubview(firstStack)
        
        firstStack.topAnchor.constraint(equalTo: zeroStack.bottomAnchor, constant: 8).isActive = true
        firstStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let secondStack = createStackView()
        let button4 = makeButton(withText: "4")
        let button5 = makeButton(withText: "5")
        let button6 = makeButton(withText: "6")
        let buttonMinus = makeButton(withText: "-")
        
//        button4.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button5.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button6.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonMinus.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        secondStack.addArrangedSubview(button4)
        secondStack.addArrangedSubview(button5)
        secondStack.addArrangedSubview(button6)
        secondStack.addArrangedSubview(buttonMinus)
        addSubview(secondStack)
        
        secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 8).isActive = true
        secondStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let thirdStack = createStackView()
        let button1 = makeButton(withText: "1")
        let button2 = makeButton(withText: "2")
        let button3 = makeButton(withText: "3")
        let buttonPlus = makeButton(withText: "+")
        
//        button1.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button2.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button3.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonPlus.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        thirdStack.addArrangedSubview(button1)
        thirdStack.addArrangedSubview(button2)
        thirdStack.addArrangedSubview(button3)
        thirdStack.addArrangedSubview(buttonPlus)
        addSubview(thirdStack)
        
        thirdStack.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 8).isActive = true
        thirdStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thirdStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let fourthStack = createStackView()
        
        let buttonComma = makeButton(withText: ".")
        let button0 = makeButton(withText: "0")
        let buttonEquals = makeButton(withText: "=")
        let buttonBackspace = makeButton(withText: "←")
        
//        buttonComma.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        button0.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        buttonEquals.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
//        buttonBackspace.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        fourthStack.addArrangedSubview(button0)
        fourthStack.addArrangedSubview(buttonComma)
        fourthStack.addArrangedSubview(buttonBackspace)
        fourthStack.addArrangedSubview(buttonEquals)
        addSubview(fourthStack)
        
        fourthStack.topAnchor.constraint(equalTo: thirdStack.bottomAnchor, constant: 8).isActive = true
        fourthStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fourthStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
