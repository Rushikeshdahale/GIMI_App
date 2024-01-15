//
//  secondViewController.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 23/11/23.
//
import UIKit

class BmrConverter: UIViewController {
    
    // Outlets
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightFeetTextField: UITextField!
    @IBOutlet weak var heightInchTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    
    // Action for the Calculate button
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        calculateIdealWeight()
    }
    
    // Function to calculate ideal weight
    func calculateIdealWeight() {
        // Ensure all the required text fields have values
        guard let ageText = ageTextField.text,
              let heightFeetText = heightFeetTextField.text,
              let heightInchText = heightInchTextField.text,
              let age = Int(ageText),
              let heightFeet = Double(heightFeetText),
              let heightInch = Double(heightInchText) else {
            // Display an error message if any input is missing
            resultLabel.text = "Invalid input. Please enter valid values."
            return
        }
        
        // Calculate height in meters
        let heightMeters = (heightFeet * 0.3048) + (heightInch * 0.0254)
        
        // Calculate BMI using the formula: BMI = weight / (height * height)
        let bmi: Double
        if heightMeters != 0 {
            // 703 is a constant for the BMI formula when weight is in pounds and height is in inches
            bmi = 703 * (Double(age) / (heightMeters * heightMeters))
        } else {
            // Handle division by zero
            resultLabel.text = "Invalid height. Please enter valid height values."
            return
        }
        
        // Determine gender factor
        let genderFactor: Double = genderSegmentedControl.selectedSegmentIndex == 0 ? 1.0 : 0.9
        
        // Calculate ideal weight
        let idealWeight = bmi * genderFactor
        
        // Display the result with two decimal places in the format "56.33 kg"
        let formattedIdealWeight = String(format: "%.2f", idealWeight)
        resultLabel.text = "Ideal Weight: \(formattedIdealWeight) kg"
    }
}
