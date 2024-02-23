//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Michael Martell on 2/23/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    
    func getBMIValue () -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    
    func getAdvice () -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor () -> UIColor {
        return bmi?.color ?? .gray
    }
    
    
    mutating func calculateBMI (height: Float, weight: Float) {
        let bmiValue = weight / pow(height, 2)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat More Pies", color: .blue)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle", color: .green)
        } else {
            bmi = BMI(value: bmiValue, advice: "No More Pies", color: .red)
        }
        
    }
}
