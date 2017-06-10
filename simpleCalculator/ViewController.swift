//
//  ViewController.swift
//  simpleCalculator
//
//  Created by Robert Cristian on 10/06/2017.
//  Copyright © 2017 Robert Cristian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultDisplay: UILabel!
    
    var previousNumber = ""
    var canClear = false
    var operand = ""
    var result = 0
    var beforeOperation = false
    var performOperation = false
    var isInTheMiddleOfTyping = false;
    var previousOperand = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        var textCurrentlyInDisplay = resultDisplay.text!
        
        if canClear {
            if beforeOperation {
                textCurrentlyInDisplay = ""
                beforeOperation = false
                performOperation = true
            }
            resultDisplay.text = textCurrentlyInDisplay + digit
        } else {
            if isInTheMiddleOfTyping {
                resultDisplay.text = textCurrentlyInDisplay + digit
                previousNumber = resultDisplay.text!
            } else {
                resultDisplay.text = digit
                previousNumber = resultDisplay.text!
                isInTheMiddleOfTyping = true
            }
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        operand = sender.currentTitle!
        canClear = true
        beforeOperation = true
        
        switch operand {
        case "+":
            previousOperand = "+"
        case "-":
            previousOperand = "-"
        case "✕":
            previousOperand = "✕"
        case "÷":
            previousOperand = "÷"
        default: break
        }
        
        if operand == "C" || operand == "√" || operand == "=" {
            performOperation = true
        }
        
        if performOperation {
            calculate()
        }
    }
    
    func calculate() {
        if operand == "=" {
            operand = previousOperand
        }
        performOperation = false
        switch operand {
        case "+":
            result = Int(previousNumber)! + Int(resultDisplay.text!)!
            resultDisplay.text = String(result)
            previousNumber = String(result)
        case "-":
            result = Int(previousNumber)! - Int(resultDisplay.text!)!
            resultDisplay.text = String(result)
            previousNumber = String(result)
        case "✕":
            result = Int(previousNumber)! * Int(resultDisplay.text!)!
            resultDisplay.text = String(result)
            previousNumber = String(result)
        case "÷":
            result = Int(previousNumber)! / Int(resultDisplay.text!)!
            resultDisplay.text = String(result)
            previousNumber = String(result)
        case "C":
            resultDisplay.text = ""
            previousNumber = ""
            canClear = false
            result = 0
            beforeOperation = false
        case "√":
            let sqroot = Double(resultDisplay.text!)!
            resultDisplay.text = String(sqrt(sqroot))
            previousNumber = String(sqroot)
        default: break
        }
    }
}

