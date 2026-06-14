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
        
        //Delegate
        emailAddressTxtField.delegate = self
        passwordTxtField.delegate = self
        
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
        
        emailAddressTxtField.keyboardType = .emailAddress
        emailAddressTxtField.returnKeyType = .next
        passwordTxtField.returnKeyType = .done
        passwordTxtField.isSecureTextEntry = true
        passwordTxtField.textContentType = .oneTimeCode
        
        //Test Purpose - Start
//        emailAddressTxtField.text = "adwiksajeev@gmail.com"
//        passwordTxtField.text = "adwikvvv"
        //Test Purpose - End
        
        
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
            self.emailAddressTxtField.text = ""
            self.passwordTxtField.text = ""
        }
        
        registerVC.modalTransitionStyle = .crossDissolve
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
        
    }
    
    
    private func togglePasswordTextVisibility(button: UIButton) {
        
        self.passwordTxtField.isSecureTextEntry.toggle()
        
        let image = passwordTxtField.isSecureTextEntry ? "eye.slash" : "eye"
        button.setImage(UIImage(systemName: image), for: .normal)
        
    }
    
    
}


extension LoginViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailAddressTxtField {
            passwordTxtField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
    }
    
    
}



extension LoginViewController {
    
    //MARK: - Auth Functions
    
    
    private func signInCall() {
        
        
        guard let email = emailAddressTxtField.text, let password = passwordTxtField.text else {
            return
        }
        
        guard Common.isValidEmail(email) else {
            emailAddressTxtField.text = ""
            CustomAlertView.showCustomErrorMessage(titleMsg: "Please enter a valid email address")
            return
        }
        
        
        guard password.count >= 6 else {
            passwordTxtField.text = ""
            CustomAlertView.showCustomErrorMessage(titleMsg: "Password must contain atleast 6 characters")
            return
        }
        
        //Logging in users
        UserAuthentication.shared.loginUserFireBaseCall(email: email, password: password) { loginSuccess in
            
            if loginSuccess {
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let homeVc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                
                homeVc.modalTransitionStyle = .crossDissolve
                homeVc.modalPresentationStyle = .fullScreen
                self.present(homeVc, animated: true)
            }else{
                
                print("Stay in the same page")
                
            }
            
        }
        
        
    }
    
    
    private func forgotPasswordCall() {
        
        
        guard let email = emailAddressTxtField.text else { return }
        
        guard Common.isValidEmail(email) else {
            CustomAlertView.showCustomErrorMessage(titleMsg: "Please enter a valid email address")
            return
        }
        
        UserAuthentication.shared.forgotPasswordCall(email: email)
        
        
    }
    
    
}
