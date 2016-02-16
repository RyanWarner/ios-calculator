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
	private enum Op: CustomDebugStringConvertible
	{
		case Operand( Double )
		case UnaryOperation( String, Double -> Double )
		case BinaryOperation( String, ( Double, Double ) -> Double )
		
		var debugDescription: String
		{
			get
			{
				switch self
				{
				case .Operand( let operand ):
					return "\(operand)"
				case .UnaryOperation( let symbol, _ ):
					return symbol
				case .BinaryOperation( let symbol, _ ):
					return symbol
				}
			}
		}
	}

	private var opStack = [Op](  )
	private var knownOperations = [String:Op](  )		// Dictionary<String, Op>()
	
	init(  )
	{
		knownOperations["×"] = Op.BinaryOperation("×", *)
		knownOperations["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
		knownOperations["+"] = Op.BinaryOperation("+", +)
		knownOperations["−"] = Op.BinaryOperation("−") { $1 - $0 }
		knownOperations["√"] = Op.UnaryOperation("√", sqrt)
	}


	// This function returns a tuple
	private func evaluate( ops: [Op] ) -> ( result: Double?, remainingOps: [Op] )
	{
		if !ops.isEmpty
		{
			var remainingOps = ops
			let op = remainingOps.removeLast(  )
			
			switch op
			{
				case .Operand( let operand ):
					return ( operand, remainingOps )

				case .UnaryOperation(_, let operation ):
					let operandEvaluation = evaluate(remainingOps)
					if let operand = operandEvaluation.result
					{
						return ( operation( operand ), operandEvaluation.remainingOps )
					}

				case .BinaryOperation(_, let operation):

					let op1Evaluation = evaluate(remainingOps)
					if let operand1 = op1Evaluation.result
					{
						let op2Evaluation = evaluate(op1Evaluation.remainingOps)
						if let operand2 = op2Evaluation.result
						{
							return (operation(operand1, operand2), op2Evaluation.remainingOps)
						}
					}
			}
		}

		return ( nil, ops )
	}
	
	func evaluate(  ) -> Double?
	{
		let (result, _) = evaluate( opStack )
		print( "\(opStack) = \(result) with left over" )
		return result
	}
	
	func pushOperand( operand: Double ) -> Double?
	{
		opStack.append( Op.Operand( operand ) )
		return evaluate(  )
	}
	
	func performOperation( symbol: String ) -> Double?
	{
		// Whenever you look something up in a dictionary, it returns an optional

		if let operation = knownOperations[symbol]
		{
			opStack.append( operation )
		}

		return evaluate(  )
	}

	
}
