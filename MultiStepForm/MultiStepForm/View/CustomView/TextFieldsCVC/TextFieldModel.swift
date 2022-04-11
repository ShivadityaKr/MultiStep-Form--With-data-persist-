//
//  TextFieldModel.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 10/04/22.
//

import UIKit
import SwiftKeychainWrapper
class TextFieldModel: NSObject{
    var viewModel : FieldDataSource? {
        didSet {
            setKeyChain()
        }
    }
    func setKeyChain() {
        let firstField = viewModel?.firstField ?? ""
        let secondField = viewModel?.secondField ?? ""
        switch viewModel?.fieldId {
        case 0 :
            KeychainWrapper.standard.set(firstField, forKey: "email")
            KeychainWrapper.standard.set(secondField, forKey: "phone")
            break
        case 1 :
            KeychainWrapper.standard.set(firstField, forKey: "fName")
            KeychainWrapper.standard.set(secondField, forKey: "lName")
            break
        case 2 :
            KeychainWrapper.standard.set(firstField, forKey: "company")
            KeychainWrapper.standard.set(secondField, forKey: "job")
            break
        default :
            break
        }
    }
}
