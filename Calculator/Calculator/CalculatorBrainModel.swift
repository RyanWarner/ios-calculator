//
//  CalculatorBrainModel.swift
//  Calculator
//
//  Created by Ryan Warner on 2/16/16.
//  Copyright © 2016 Ryan Warner. All rights reserved.
//

import Foundation

class CalculatorBrainModel
{
	enum Op
	{
		case Operand( Double )
		case UnaryOperation( String, Double -> Double )
		case BinaryOperation( String, ( Double, Double ) -> Double )
	}

	var opStack = [Op]()

	
}
