//
//  ViewController.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var isFinishedTypingNumber: Bool = false
    var cView: CalculatorView
    var stackView: UIStackView
    
    var displayValue: Double {
        get {
            guard let number = Double(cView.outputField.text!) else {
                return Double(0)
            }
            return number
        }
        set {
            if newValue == 0 {
                cView.outputField.text = "0"
            } else {
                cView.outputField.text = String(newValue.withCommas())
            }
            
            if newValue.truncatingRemainder(dividingBy: 1) == 0 {
                cView.outputField.text = String(newValue.withCommas())
            }
        }
    }
    
    init() {
        stackView = createStackView()
        cView = CalculatorView()
        super.init(nibName: nil, bundle: nil)
        cView.outputField.text = "0"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        stackView.addArrangedSubview(cView)
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private var calculator = CalculatorLogic()
    @objc func calcButtonPressed(_ sender: UIButton) {
        //What should happen when an = button is pressed
//        isFinishedTypingNumber = true
//        calculator.setNumber(displayValue)
//        
//        if let calcMethod = sender.currentTitle {
//            if calcMethod == "C" {
////          buttonAC.setTitle("AC", for: .normal)
//            }
//            if let result = calculator.calculate(symbol: calcMethod) {
//                displayValue = result
//            }
//        }
    }
    
            
    @objc func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber == true {
                if numValue == "←" {
                    if cView.outputField.text!.count > 1 {
                        cView.outputField.text?.removeLast()
                    } else {
                        displayValue = Double(0)
                    }
                    
                } else {
                    cView.outputField.text = numValue
                    isFinishedTypingNumber = false
                }
            } else {
                if numValue == "←" {
                    
                    if cView.outputField.text!.count > 1 {
                        cView.outputField.text?.removeLast()
                    } else {
                        displayValue = Double(0)
                        isFinishedTypingNumber = true
                    }
                } else if numValue == "." { // more than one "." fix
                    if displayValue == 0 {
                        cView.outputField.text = "0."
                        isFinishedTypingNumber = false
                        return
                    }
                    let isInt = !cView.outputField.text!.contains(".")
                    if !isInt { return }
                } else if cView.outputField.text == "0" || isFinishedTypingNumber {
                    cView.outputField.text = numValue
                    isFinishedTypingNumber = false
                } else {
                    cView.outputField.text?.append(numValue)
                }
            }
        }
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 7  // default is 3 decimals
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
