//
//  UITextFieldDelegateMethod.swift
//  Code Snippets
//
//  Created by Mike Miksch on 6/8/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

import UIKit

func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    switch string {
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
        return true
    case "." :
        let inputArray = Array(textField.text!.characters)
        var decimalCount = 0
        for character in inputArray {
            if character == "." {
                decimalCount += 1
            }
        }
        
        if decimalCount == 1 {
            return false
        } else {
            return true
        }
    default:
        let inputArray = Array(string.characters)
        if inputArray.count == 0 {
            return true
        }
        return false
    }
}
