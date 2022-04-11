//
//  String+TextFieldValidation.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 10/04/22.
//

import UIKit

extension String {
    var validateName : Bool {
        let nameRegex = "^[A-Za-z]{3,18}$"
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    var validateRegularName : Bool {
        let RegEx = "[a-zA-Z][a-zA-Z ]*"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    var validatePhoneNumber : Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    var validateEmailId : Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
}

