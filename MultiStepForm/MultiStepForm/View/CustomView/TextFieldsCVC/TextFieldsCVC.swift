//
//  TextFieldsCVC.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 09/04/22.
//

import UIKit
import SwiftKeychainWrapper

protocol FieldDataSource : AnyObject {
    var firstField: String {get}
    var secondField : String {get}
    var fieldId : Int {get}
}
class TextFieldsCVC: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    var scrollRightDelegate : ScrollRight!
    var firstFieldData : String?
    var secondFieldData : String?
    var viewModel : TextFieldModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    var id : Int! {
        didSet {
            getKeychain()
        }
    }
    private func setupUI() {
        setTextField(textField: firstTF)
        setTextField(textField: secondTF)
        setNextButton()
        validateFileds()
    }
    func validateFileds() {
        firstTF.addTarget(self, action: #selector(isEditingFirstTF), for: .editingChanged)
        secondTF.addTarget(self, action: #selector(isEditingSecondTF), for: .editingChanged)
    }
    @objc func isEditingFirstTF() {
        setFirstValidation(id: self.id)
    }
    @objc func isEditingSecondTF() {
        setSecondValidation(id: self.id)
    }
    private func setFirstValidation(id: Int) {
        switch id {
        case 0 :
            //email
            if firstTF.text?.validateEmailId == false {
                setInvalidField(textField: firstTF)
            } else {
                setValidField(textField: firstTF)
            }
            break
        case 1 :
            //fname
            if firstTF.text?.validateName == false {
                setInvalidField(textField: firstTF)
            } else {
                setValidField(textField: firstTF)
            }
            break
        case 2 :
            //company
            if firstTF.text?.validateRegularName == false {
                setInvalidField(textField: firstTF)
            } else {
                setValidField(textField: firstTF)
            }
            break
        default: break
        }
    }
    private func setSecondValidation(id: Int) {
        switch id {
        case 0 :
            //phone
            if secondTF.text?.validatePhoneNumber == false {
                setInvalidField(textField: secondTF)
            } else {
                setValidField(textField: secondTF)
            }
            break
        case 1 :
            //lname
            if secondTF.text?.validateName == false {
                setInvalidField(textField: secondTF)
            } else {
                setValidField(textField: secondTF)
            }
            break
        case 2 :
            //job
            if secondTF.text?.validateRegularName == false {
                setInvalidField(textField: secondTF)
            } else {
                setValidField(textField: secondTF)
            }
            break
        default: break
        }
    }
    func setData(data: UIElements.TextFieldData, id: Int) {
        self.id = id
        titleLabel.text = data.title
        firstTF.placeholder = data.firstTFPH
        secondTF.placeholder = data.secondTFPH
        nextButton.setTitle(data.nextButton, for: .normal)
    }
    private func setTextField(textField : UITextField) {
        textField.layer.borderWidth = 0.8
        textField.layer.cornerRadius = 25
        textField.layer.borderColor = UIColor.darkGray.cgColor
    }
    private func setNextButton() {
        nextButton.backgroundColor = .systemTeal
        nextButton.layer.cornerRadius = 25
        nextButton.tintColor = .white
        nextButton.addTarget(self, action: #selector(didNextButtonTap), for: .touchUpInside)
        inActiveButton()
    }
    private func setInvalidField(textField: UITextField) {
        inActiveButton()
        textField.layer.borderColor = UIColor.red.cgColor
    }
    private func setValidField(textField: UITextField) {
        if isEmpty() {
            activateButton()
        }
        textField.layer.borderColor = UIColor.green.cgColor
    }
    private func activateButton() {
        nextButton.isUserInteractionEnabled = true
        nextButton.alpha = 1
    }
    private func inActiveButton() {
        nextButton.isUserInteractionEnabled = false
        nextButton.alpha = 0.5
    }
    private func isEmpty() -> Bool {
        if firstTF.text?.isEmpty ?? false || secondTF.text?.isEmpty ?? false {
            return false
        } else {
            return true
        }
    }
    @objc func didNextButtonTap() {
        firstFieldData = firstTF.text
        secondFieldData = secondTF.text
        viewModel.viewModel = self
        scrollRightDelegate.scrollRight()
        
    }
    func getKeychain() {
        switch id {
        case 0 :
            setDataFromKey(firstKey: "email", secondKey: "phone")
            break
        case 1 :
            setDataFromKey(firstKey: "fName", secondKey: "lName")
            break
        case 2 :
            setDataFromKey(firstKey: "company", secondKey: "job")
            break
        default: break
        }
    }
    private func setDataFromKey(firstKey: String, secondKey: String) {
        let firstKC = KeychainWrapper.standard.string(forKey: firstKey)
        let secondKC = KeychainWrapper.standard.string(forKey: secondKey)
        if firstKC != nil && secondKC != nil{
            firstTF.text = firstKC
            secondTF.text = secondKC
            activateButton()
        }
    }
}
extension TextFieldsCVC : FieldDataSource {
    var fieldId: Int {
        return id
    }
    var firstField: String {
        return firstFieldData ?? ""
    }
    
    var secondField: String {
        return secondFieldData ?? ""
    }
}
