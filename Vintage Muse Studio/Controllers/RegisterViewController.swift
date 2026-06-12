//
//  ViewController.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 09/06/26.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    var goBackToLoginVC: (() -> Void)?
    
    //View
    @IBOutlet var authViews: [UIView]!
    
    //Textfield
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var emailAddressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    
    //Label
    @IBOutlet weak var signInLbl: UILabel!
    
    //Scrollview
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialUIchanges()
        
    }
    
    
    //IBActions
    
    @IBAction func goToLoginVC(_ sender: UIButton) {
        
        goBackToLoginVC?()
        dismiss(animated: true)
        
    }
    
    @IBAction func didCreateAccountButtonTapped(_ sender: UIButton) {
        
        createAccountCall()
        
    }
    
    
    @IBAction func didHidePasswordButtonTapped(_ sender: UIButton) {
        
        togglePasswordTextVisibility(button: sender)
        
    }
    
    
    @IBAction func didHideConfirmPasswordButtonTapped(_ sender: UIButton) {
        
        toggleConfirmPasswordTextVisibility(button: sender)
        
    }

}



//MARK: - Private Functions

extension RegisterViewController {
    
    private func initialUIchanges() {
        
        view.backgroundColor = .bg
        
        fullNameTxtField.autocapitalizationType = .words
        
        emailAddressTxtField.keyboardType = .emailAddress
        emailAddressTxtField.returnKeyType = .next
        
        passwordTxtField.returnKeyType = .next
        passwordTxtField.isSecureTextEntry = true
        
        confirmPasswordTxtField.returnKeyType = .done
        confirmPasswordTxtField.isSecureTextEntry = true
        
        guard let borderColor = UIColor(named: VMThemeColor.descriptionTextColor) else { return }
        authViews.applyBorder(color: borderColor, alpha: 0.5 ,borderWidth: 1, cornerRadius: 10)
        
        
        
        //Custom placeholder UI changes
        let textFields: [(UITextField, String)] = [
            (fullNameTxtField, "Full Name"),
            (emailAddressTxtField, "Email Address"),
            (passwordTxtField, "Password"),
            (confirmPasswordTxtField, "Confirm Password")
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
    
    
}



//MARK: - Private Functions
extension RegisterViewController {
    
    
    private func createAccountCall() {
        
        
        guard
            let fullName = fullNameTxtField.text ,
            let email = emailAddressTxtField.text,
            let password = passwordTxtField.text,
            let confirmPassword = confirmPasswordTxtField.text
                
        else { return }
        
        guard !fullName.isEmpty else {
            CustomAlertView.showCustomErrorMessage(titleMsg: "Please enter your name")
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
        
        
        guard confirmPassword == password else {
            confirmPasswordTxtField.text = ""
            CustomAlertView.showCustomErrorMessage(titleMsg: "Confirm password doesn't match")
            return
        }
        
        
        CustomAlertView.showCustomSuccessMessage(titleMsg: "Registration success")
        
        
    }
    
    
    private func togglePasswordTextVisibility(button: UIButton) {
        
        passwordTxtField.isSecureTextEntry.toggle()
        
        let image = passwordTxtField.isSecureTextEntry ? "eye.slash" : "eye"
        button.setImage(UIImage(systemName: image), for: .normal)
        
    }
    
    private func toggleConfirmPasswordTextVisibility(button: UIButton) {
        
        confirmPasswordTxtField.isSecureTextEntry.toggle()
        
        let image = confirmPasswordTxtField.isSecureTextEntry ? "eye.slash" : "eye"
        button.setImage(UIImage(systemName: image), for: .normal)
        
    }
    
    
}



extension RegisterViewController: UITextFieldDelegate {
    
    
    
}
