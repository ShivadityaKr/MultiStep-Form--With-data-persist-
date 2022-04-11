//
//  SplashVC.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 09/04/22.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadscreen()
    }
    private func loadscreen(){
        let vc = HomeVC.instantiate()
        UIStoryboard.makeNavigationControllerAsRootVC(vc)
    }
}
