//
//  utilities.swift
//  SoulSync
//
//  Created by Jeegrra on 10/04/2024.
//

import Foundation
import UIKit

class Utilities {
    //validate password
    static func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        let passwordRegex = "^(?=.*[a-z])(?=.*[\\$@#!%*?&])[A-Za-z\\d\\$@#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    //validate email
    static func isEmailValid(_ email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    static func isMobileNumberValid(_ mobileNumber: String?) -> Bool {
        guard let mobileNumber = mobileNumber else {
            return false
        }
        let mobileNumberRegex = "^[0-9]{7,15}$"
        let mobileNumberTest = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberTest.evaluate(with: mobileNumber)
    }

}
