//
//  ViewController.swift
//  Calculator
//
//  Created by Ryan Warner on 2/14/16.
//  Copyright © 2016 Ryan Warner. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var calcDisplay: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false

    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTypingANumber
        {
            calcDisplay.text = calcDisplay.text! + digit
        }
        else
        {
            calcDisplay.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    var operandStack = Array<Double>()

    @IBAction func enter(  )
    {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
    }
    
    var displayValue: Double
    {
        get
        {
            return NSNumberFormatter().numberFromString(calcDisplay.text!)!.doubleValue
        }
        
        set
        {
            calcDisplay.text = "\(newValue)"
        }
    }
}
