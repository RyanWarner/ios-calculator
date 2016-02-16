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
	
	var brain = CalculatorBrainModel()

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

    @IBAction func enter(  )
    {
        userIsInTheMiddleOfTypingANumber = false

		if let result = brain.pushOperand(displayValue)
		{
			displayValue = result
		}
		else
		{
			displayValue = 999
		}
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
		if userIsInTheMiddleOfTypingANumber
		{
			enter(  )
		}

        if let operation = sender.currentTitle
		{
			if let result = brain.performOperation(operation)
			{
				displayValue = result
			}
			else
			{
				displayValue = 888
			}
		}
		
		
	}
}
