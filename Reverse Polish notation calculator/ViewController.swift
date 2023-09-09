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
        setupButtonActions()
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
    
    func setupButtonActions() {
        cView.buttonAC.addTarget(self, action: #selector(acButtonPressed(_:)), for: .touchUpInside)
        cView.buttonOpeningBracket.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.buttonClosingBracket.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
//        cView.buttonSign.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside) // isn't used
//        cView.buttonPercentage.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside) // isn't used
        cView.buttonDivision.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside) 
        
        cView.buttonMultiplication.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button7.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button8.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button9.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        cView.button4.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button5.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button6.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.buttonMinus.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)

        cView.button1.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button2.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button3.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.buttonPlus.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        
        cView.buttonComma.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.button0.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
        cView.buttonEquals.addTarget(self, action: #selector(calcButtonPressed(_:)), for: .touchUpInside)
        cView.buttonBackspace.addTarget(self, action: #selector(numButtonPressed(_:)), for: .touchUpInside)
    }
    
    private var calculator = CalculatorLogic()
    @objc func calcButtonPressed(_ sender: UIButton) {
        //What should happen when "=" button is pressed
        calculator.setline(cView.outputField.text!)
        
        if let result = calculator.theResult {
            displayValue = result
        }
    }
    
    @objc func acButtonPressed(_ sender: UIButton) {
        displayValue = Double(0)
    }
    
    @objc func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            if numValue == "←" {
                if cView.outputField.text!.count > 1 {
                    cView.outputField.text?.removeLast()
                } else {
                    displayValue = Double(0)
                }
            } else {
                if cView.outputField.text == "0" {
                    cView.outputField.text = numValue
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
