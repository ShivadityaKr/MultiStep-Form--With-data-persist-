//
//  HomeVC.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 09/04/22.
//

import UIKit
protocol HomeView : UIViewController {
    var navBarView: NavBarView! {get}
    var progressView: UIProgressView! {get}
    var collectionView: UICollectionView! {get}
}

class HomeVC: UIViewController, HomeView{
    var dataList: [String] = []
    @IBOutlet weak var navBarView: NavBarView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var collectionView: UICollectionView!
    var uiVc : HomeUIVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiVc.view = self
    }
    class func instantiate() -> HomeVC {
        let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
        vc.uiVc = HomeUIVC()
        return vc
    }
}

struct UIElements {
    struct ButtonData {
        var title : String
        var firstButtonTitle : String
        var secondButtonTitle : String
        var thirdButtonTitle : String
    }
    struct TextFieldData {
        var title : String
        var firstTFPH : String
        var secondTFPH : String
        var nextButton : String
    }
    static var buttonDataList : [UIElements.ButtonData] {
        return [
            ButtonData(title: "Welcome!😊 What are you looking for?", firstButtonTitle: "Lead generation bots", secondButtonTitle: "Muti-step forms", thirdButtonTitle: "Integrations"),
            ButtonData(title: "Great! what department do you work in?", firstButtonTitle: "Marketing", secondButtonTitle: "Sales", thirdButtonTitle: "Customer service")
        ]
    }
    static var textFieldData : [UIElements.TextFieldData] {
        return [
            TextFieldData(title: "What is the email and phone number that we can reach yuu the best?", firstTFPH: "Email address*", secondTFPH: "Phone*", nextButton: "Next"),
            TextFieldData(title: "Could you tell us a bit more about yourself?", firstTFPH: "First name*", secondTFPH: "Last name*", nextButton: "Next"),
            TextFieldData(title: "Thanks!😊 Just a few more details and we are done!", firstTFPH: "Company name*", secondTFPH: "Job title*", nextButton: "Request demo")
        ]
    }
}
