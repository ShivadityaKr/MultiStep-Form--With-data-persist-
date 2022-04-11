//
//  NavBarView.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 09/04/22.
//

import UIKit

class NavBarView: UIView {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("NavBarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = .white
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        setButton(button: self.backButton, imageName: "chevron.backward.2")
        setButton(button: self.crossButton, imageName: "xmark")
    }
    private func setButton(button: UIButton, imageName: String) {
        button.setTitle(nil, for: .normal)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.tintColor = .darkGray
    }
}
