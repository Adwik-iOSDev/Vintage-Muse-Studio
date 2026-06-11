//
//  LoginViewController.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 11/06/26.
//

import UIKit

class LoginViewController: UIViewController {

    
    //View
    @IBOutlet var authViews: [UIView]!
    
    //Textfield
    @IBOutlet weak var emailAddressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    //Scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialUIchanges()
        
    }
    
    //IBActions
    
    @IBAction func goToRegisterVC(_ sender: UIButton) {
        
        navigateToRegisterVC()
        
    }

}



//MARK: - Private Functions

extension LoginViewController {
    
    
    private func initialUIchanges() {
        
        view.backgroundColor = .bg
        
        guard let borderColor = UIColor(named: VMThemeColor.descriptionTextColor) else { return }
        authViews.applyBorder(color: borderColor, alpha: 0.5 ,borderWidth: 1, cornerRadius: 10)
        
        
        //Custom placeholder UI changes
        let textFields: [(UITextField, String)] = [
            (emailAddressTxtField, "Email Address"),
            (passwordTxtField, "Password")
        ]
        
        
        textFields.forEach { textField, placeHolder in
            textField.applyPlaceholderChanges(
                placeholderText: placeHolder,
                colorString: VMThemeColor.descriptionTextColor,
                alpha: 0.6,
                fontSize: 18,
                fontWeight: .medium
            )
        }
        
        scrollView.bounces = false
        
    }
    
    
    private func navigateToRegisterVC() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController")as! RegisterViewController
        
        registerVC.goBackToLoginVC = {
            self.scrollView.contentOffset.y = 0
        }
        
        registerVC.modalTransitionStyle = .crossDissolve
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
        
    }
    
    
}
