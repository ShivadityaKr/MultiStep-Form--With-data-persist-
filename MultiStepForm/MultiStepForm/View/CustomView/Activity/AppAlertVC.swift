//
//  AppAlertVC.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 10/04/22.
//

import UIKit
import SwiftKeychainWrapper

class AppAlertVC: UIViewController {

    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var clickButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupUI()
    }
    private func setData() {
        let email = KeychainWrapper.standard.string(forKey: "email")
        let phone = KeychainWrapper.standard.string(forKey: "phone")
        let fName = KeychainWrapper.standard.string(forKey: "fName")
        let lName = KeychainWrapper.standard.string(forKey: "lName")
        let company = KeychainWrapper.standard.string(forKey: "company")
        let job = KeychainWrapper.standard.string(forKey: "job")
        nameLabel.text = "Hii! \(fName ?? "") \(lName ?? "")"
        emailLabel.text = "Email: \(email ?? "")"
        phoneLabel.text = "Phone: \(phone ?? "")"
        companyLabel.text = "Company: \(company ?? "")"
        jobLabel.text = "Job: \(job ?? "")"
        
    }
    private func setupUI() {
        //button
        clickButton.backgroundColor = .systemTeal
        clickButton.layer.cornerRadius = 25
        clickButton.tintColor = .white
        clickButton.addTarget(self, action: #selector(didTapClick), for: .touchUpInside)
        //navbar
        navBarView.backButton.isHidden = true
        navBarView.crossButton.addTarget(self, action: #selector(didCrossTap), for: .touchUpInside)
    }
    @objc func didCrossTap() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func didTapClick() {
        KeychainWrapper.standard.remove(forKey: "email")
        KeychainWrapper.standard.remove(forKey: "phone")
        KeychainWrapper.standard.remove(forKey: "fName")
        KeychainWrapper.standard.remove(forKey: "lName")
        KeychainWrapper.standard.remove(forKey: "company")
        KeychainWrapper.standard.remove(forKey: "job")
        let vc = HomeVC.instantiate()
        self.present(vc, animated: true, completion: nil)
    }
    class func instanciate() -> AppAlertVC {
        let vc = UIStoryboard.appAlert.instanceOf(viewController: AppAlertVC.self)!
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
