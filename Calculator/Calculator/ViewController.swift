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
    

    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        print( "digit: \(digit)" )
    }
}
