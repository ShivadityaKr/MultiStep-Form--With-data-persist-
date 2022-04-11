//
//  ButtonsCVC.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 09/04/22.
//

import UIKit
protocol ScrollRight{
    func scrollRight()
}
class ButtonsCVC: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    var scrollRightDelegate : ScrollRight!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        //buttons
        setButton(button: firstButton)
        setButton(button: secondButton)
        setButton(button: thirdButton)
        secondButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        firstButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(didButtonTap), for: .touchUpInside)
    }
    @objc func didButtonTap() {
        self.scrollRightDelegate.scrollRight()
    }
    func setData(data: UIElements.ButtonData, id: Int) {
        titleLabel.text = data.title
        firstButton.setTitle(data.firstButtonTitle, for: .normal)
        secondButton.setTitle(data.secondButtonTitle, for: .normal)
        thirdButton.setTitle(data.thirdButtonTitle, for: .normal)
        if id == 0 {
            firstButton.isUserInteractionEnabled = false
            thirdButton.isUserInteractionEnabled = false
        } else  {
            firstButton.isUserInteractionEnabled = true
            thirdButton.isUserInteractionEnabled = true
        }
    }
    private func setButton(button: UIButton) {
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 25
        button.tintColor = .white
    }
}
