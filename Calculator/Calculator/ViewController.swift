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
            return Double(calcDisplay.text!)!
		}
        
        set
        {
            calcDisplay.text = "\(newValue)"
        }
    }

    @IBAction func operate(sender: UIButton)
	{
        let operation = sender.currentTitle!
		
		if userIsInTheMiddleOfTypingANumber
		{
			enter(  )
		}

        switch operation
		{
			case "×": performOperation { $0 * $1 }
			case "÷": performOperation { $1 / $0 }
			case "+": performOperation { $0 + $1 }
			case "−": performOperation { $1 - $0 }
			case "√": performOperation { sqrt($0) }
            default: break
        }
    }
	
	func performOperation( operation: ( Double, Double ) -> Double )
	{
		if operandStack.count >= 2
		{
			displayValue = operation( operandStack.removeLast(), operandStack.removeLast() )
			enter(  )
		}
	}
	
	@nonobjc
	func performOperation( operation: Double -> Double )
	{
		if operandStack.count >= 1
		{
			displayValue = operation( operandStack.removeLast() )
			enter(  )
		}
	}
}
