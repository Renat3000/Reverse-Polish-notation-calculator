//
//  CalculatorView.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import UIKit

class CalculatorView: UIView {
    
    var outputField: UILabel
    var buttonAC, buttonOpeningBracket, buttonClosingBracket, buttonSign, buttonPercentage, buttonDivision, buttonMultiplication, buttonPlus, buttonMinus, buttonComma, buttonEquals, buttonBackspace, button0, button1, button2, button3, button4, button5, button6, button7, button8, button9: UIButton!
    
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
        buttonAC = makeButton(withText: "AC")
        buttonAC.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonOpeningBracket = makeButton(withText: "(")
        buttonClosingBracket = makeButton(withText: ")")
        buttonSign = makeButton(withText: "±")
        buttonPercentage = makeButton(withText: "%")
        buttonDivision = makeButton(withText: "÷")
        
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
        button7 = makeButton(withText: "7")
        button8 = makeButton(withText: "8")
        button9 = makeButton(withText: "9")
        buttonMultiplication = makeButton(withText: "×")
        
        firstStack.addArrangedSubview(button7)
        firstStack.addArrangedSubview(button8)
        firstStack.addArrangedSubview(button9)
        firstStack.addArrangedSubview(buttonMultiplication)
        addSubview(firstStack)
        
        firstStack.topAnchor.constraint(equalTo: zeroStack.bottomAnchor, constant: 8).isActive = true
        firstStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let secondStack = createStackView()
        button4 = makeButton(withText: "4")
        button5 = makeButton(withText: "5")
        button6 = makeButton(withText: "6")
        buttonMinus = makeButton(withText: "-")
        
        secondStack.addArrangedSubview(button4)
        secondStack.addArrangedSubview(button5)
        secondStack.addArrangedSubview(button6)
        secondStack.addArrangedSubview(buttonMinus)
        addSubview(secondStack)
        
        secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 8).isActive = true
        secondStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let thirdStack = createStackView()
        button1 = makeButton(withText: "1")
        button2 = makeButton(withText: "2")
        button3 = makeButton(withText: "3")
        buttonPlus = makeButton(withText: "+")
        
        thirdStack.addArrangedSubview(button1)
        thirdStack.addArrangedSubview(button2)
        thirdStack.addArrangedSubview(button3)
        thirdStack.addArrangedSubview(buttonPlus)
        addSubview(thirdStack)
        
        thirdStack.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 8).isActive = true
        thirdStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thirdStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let fourthStack = createStackView()
        
        buttonComma = makeButton(withText: ".")
        button0 = makeButton(withText: "0")
        buttonEquals = makeButton(withText: "=")
        buttonBackspace = makeButton(withText: "←")
        
        fourthStack.addArrangedSubview(button0)
//        fourthStack.addArrangedSubview(buttonComma)
        fourthStack.addArrangedSubview(buttonBackspace)
        fourthStack.addArrangedSubview(buttonEquals)
        addSubview(fourthStack)
        
        fourthStack.topAnchor.constraint(equalTo: thirdStack.bottomAnchor, constant: 8).isActive = true
        fourthStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fourthStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
