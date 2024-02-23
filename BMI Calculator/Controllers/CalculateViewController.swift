//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    // State
    var calculatorBrain = CalculatorBrain()
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var ToggleUnitButton: UIButton!
    var isMetricUnits = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleUnitsButton(_ sender: UIButton) {
           // Toggle the units state
           isMetricUnits.toggle()
        
        if isMetricUnits {
            ToggleUnitButton.setTitle("Switch to Imperial", for: .normal)
        } else {
            ToggleUnitButton.setTitle("Switch to Metric", for: .normal)
        }
           
           if isMetricUnits {
               // Convert current height slider value to meters
               let currentValue = Double(heightLabel.text!.components(separatedBy: " ")[0]) ?? 0
               let newValue = currentValue * 0.3048 // Convert feet to meters
               heightLabel.text = "\(String(format: "%.1f", newValue)) m"
           } else {
               // Convert current height slider value to feet and inches
               let currentValue = Double(heightLabel.text!.components(separatedBy: " ")[0]) ?? 0
               let feet = Int(currentValue)
               let inches = Int((currentValue - Double(feet)) * 12)
               heightLabel.text = "\(feet) ft \(inches) in"
           }
           
           if isMetricUnits {
               // Convert current weight slider value to kilograms
               let currentValue = Double(weightLabel.text!.components(separatedBy: " ")[0]) ?? 0
               let newValue = currentValue * 0.453592 // Convert pounds to kilograms
               weightLabel.text = "\(String(format: "%.1f", newValue)) Kg"
           } else {
               // Convert current weight slider value to pounds
               let currentValue = Double(weightLabel.text!.components(separatedBy: " ")[0]) ?? 0
               let newValue = currentValue * 2.20462 // Convert kilograms to pounds
               weightLabel.text = "\(String(format: "%.1f", newValue)) lbs"
           }
       }
       
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
           let newValue = sender.value
           if isMetricUnits {
               heightLabel.text = "\(String(format: "%.1f", newValue)) m"
           } else {
               let feet = Int(newValue)
               let inches = Int((newValue - Float(feet)) * 12)
               heightLabel.text = "\(feet) ft \(inches) in"
           }
       }
       
       @IBAction func weightSliderChanged(_ sender: UISlider) {
           let newValue = sender.value
           if isMetricUnits {
               weightLabel.text = "\(String(format: "%.1f", newValue)) Kg"
           } else {
               weightLabel.text = "\(String(format: "%.1f", newValue)) Lbs"
           }
       }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weight = weightSlider.value
        calculatorBrain.calculateBMI(height: height, weight: weight)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // narrow down the destination
        if segue.identifier == "goToResult" {
            // narrow down the destination data type as ResultsViewController. This is called a downcast. Explaination mark means that we're sure the Type exists.
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }

}

