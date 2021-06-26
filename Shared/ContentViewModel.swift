//
//  ContentViewModel.swift
//  Numbers
//
//  Created by Kris Reid on 26/06/2021.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var number: Int = 0
    @Published var text: String = ""
    
    func numberConverter() {
        
        //Create some dictionaries of the raw data i'll need
        let singleDigits: [Int: String] = [0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
        let teenDigits: [Int: String] = [0: "Ten", 1: "Eleven", 2: "Twelve", 3: "Thirteen", 4: "Fourteen", 5: "Fifteen", 6: "Sixteen", 7: "Seventeen", 8: "Eighteen", 9: "Nineteen"]
        let noughtyDigits: [Int: String] = [0: "", 1: "Teens", 2: "Twenty", 3: "Thirty", 4: "Fourty", 5: "Fifty", 6: "Sixty", 7: "Seventy", 8: "Eighty", 9: "Ninety"]
        
        //Break the number into an array of Integers
        let stringDigits = String(number).compactMap{ $0.wholeNumberValue }
        
        //How many digits are in the number - needed to apply logic?
        let count = String(number).count
        
        //Use the count of digits to help determine the rules in a switch statement
        switch count {
        
        // 1 digit (i.e. 0-9)
        case 1:
            SingleDigits(singleDigits: singleDigits, stringDigits: stringDigits)
           
        // 2 digits (i.e. 10 - 99)
        case 2:
            text = DoubleDigits(singleDigits: singleDigits, teenDigits: teenDigits, noughtyDigits: noughtyDigits, stringDigits: stringDigits, hundreds: false)

        // 3 digits (i.e. 100 - 999)
        case 3:
            trebleDigits(singleDigits: singleDigits, teenDigits: teenDigits, noughtyDigits: noughtyDigits, stringDigits: stringDigits, hundreds: true)

        default:
            text = "Number is too big 🤯"
        }
    }
    
    
    private func SingleDigits(singleDigits: [Int: String], stringDigits: [Int]) {
        let matchedNumber = singleDigits.filter {$0.key == stringDigits[0]}
        text = matchedNumber.values.first ?? "Error"
    }
    
    
    func DoubleDigits(singleDigits: [Int: String], teenDigits: [Int: String], noughtyDigits: [Int: String], stringDigits: [Int], hundreds: Bool) -> String {
        
        let firstNumber = noughtyDigits.filter {$0.key == stringDigits[hundreds ? 1 : 0]}
        let teenNumber = teenDigits.filter {$0.key == stringDigits[hundreds ? 2 : 1]}
        let secondNumber = singleDigits.filter {$0.key == stringDigits[hundreds ? 2 : 1]}
        
        //sort out the teens (if the first number is 1 then reference the matchedTeenNumber (which looks at the second digit to determine the value))
        if (firstNumber == [1: "Teens"]) {
            return "\(teenNumber.values.first ?? "Error")"
        } else {
            //Sort out the 'noughties' (If the first number is 0 then only reference the matchedFirstNumber, else reference both matchedFirstNumber and matchedSecondNumber)
            if (secondNumber == [0: "Zero"]) {
                return "\(firstNumber.values.first ?? "Error")"
            } else {
                return "\(firstNumber.values.first ?? "Error") \(secondNumber.values.first ?? "Error")"
            }
        }
    }
    
    
    private func trebleDigits (singleDigits: [Int: String], teenDigits: [Int: String], noughtyDigits: [Int: String], stringDigits: [Int], hundreds: Bool) {
        
        let firstNumber = singleDigits.filter {$0.key == stringDigits[0]}
        let secondNumber = singleDigits.filter {$0.key == stringDigits[1]}
        let thirdNumber = singleDigits.filter {$0.key == stringDigits[2]}
        
        //sort out the round hundreds
        if secondNumber == [0: "Zero"] && thirdNumber == [0: "Zero"] {
            text = "\(firstNumber.values.first ?? "Error") hundred"
        } else {
            let lastTwoDigits = DoubleDigits(singleDigits: singleDigits, teenDigits: teenDigits, noughtyDigits: noughtyDigits, stringDigits: stringDigits, hundreds: hundreds)
            
            //Take the last to 2 numbers and pass them to the DoubleDigits function and get a returned response to display
            text = "\(firstNumber.values.first ?? "Error") hundred and \(lastTwoDigits)"
        }
    }

}
