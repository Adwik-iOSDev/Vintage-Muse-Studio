//
//  LoginViewController.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 11/06/26.
//

import UIKit
import SwiftMessages

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
    
    @IBAction func didSignInButtonTapped(_ sender: UIButton) {
        
        signInCall()
        
    }
    
    
    @IBAction func goToRegisterVC(_ sender: UIButton) {
        
        navigateToRegisterVC()
        
    }
    
    
    @IBAction func didUnhidePasswordButtonTapped(_ sender: UIButton) {
        
        togglePasswordTextVisibility(button: sender)
        
    }
    
    
    @IBAction func didForgotPasswordButtonTapped(_ sender: UIButton) {
        
        forgotPasswordCall()
        
    }
    

}



//MARK: - Private Functions

extension LoginViewController {
    
    
    private func initialUIchanges() {
        
        view.backgroundColor = .bg
        passwordTxtField.isSecureTextEntry = true
        
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
            
            textField.textColor = UIColor(named: VMThemeColor.headingTextColor)
            textField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            
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
    
    
    private func signInCall() {
        
        
        guard let email = emailAddressTxtField.text, let password = passwordTxtField.text else {
            return
        }
        
        guard Common.isValidEmail(email) else {
            CustomAlertView.showCustomErrorMessage(titleMsg: "Please enter a valid email address")
            return
        }
        
        
        guard password.count >= 6 else {
            CustomAlertView.showCustomErrorMessage(titleMsg: "Password must contain atleast 6 characters")
            return
        }
        
        CustomAlertView.showCustomSuccessMessage(titleMsg: "Registration success")
        
        
        
    }
    
    
    private func togglePasswordTextVisibility(button: UIButton) {
        
        self.passwordTxtField.isSecureTextEntry.toggle()
        
        let image = passwordTxtField.isSecureTextEntry ? "eye.slash" : "eye"
        button.setImage(UIImage(systemName: image), for: .normal)
        
    }
    
    
    private func forgotPasswordCall() {
        
        print("Forgot password called")
        
    }
    
    
}
