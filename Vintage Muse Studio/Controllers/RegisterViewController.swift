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
    @IBOutlet weak var verifyAccontView: UIView!
    @IBOutlet weak var createAccontView: UIView!
    
    //HeightConstraint
    @IBOutlet weak var verifyAccontViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAccontViewHeightConstraint: NSLayoutConstraint!
    
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
        
        UserAuthentication.shared.deleteUserAccount()
        dismiss(animated: true)
        
    }
    
    @IBAction func didVerifyAccountButtonTapped(_ sender: UIButton) {
        
        verifyAccountCallForCreatingNewAccountPurpose()
        
    }
    
    
    @IBAction func didCreateAccountButtonTapped(_ sender: UIButton) {
        
        createAccountCallForLoginPurpose()
        
    }
    
    
    @IBAction func didHidePasswordButtonTapped(_ sender: UIButton) {
        
        togglePasswordTextVisibility(button: sender)
        
    }
    
    
    @IBAction func didHideConfirmPasswordButtonTapped(_ sender: UIButton) {
        
        toggleConfirmPasswordTextVisibility(button: sender)
        
    }

}



//MARK: - Initial UI Set - Up

extension RegisterViewController {
    
    private func initialUIchanges() {
        
        view.backgroundColor = .bg
        
        fullNameTxtField.delegate = self
        emailAddressTxtField.delegate = self
        passwordTxtField.delegate = self
        confirmPasswordTxtField.delegate = self
        
        fullNameTxtField.autocapitalizationType = .words
        fullNameTxtField.returnKeyType = .next
        
        emailAddressTxtField.keyboardType = .emailAddress
        emailAddressTxtField.returnKeyType = .next
        
        passwordTxtField.returnKeyType = .next
        passwordTxtField.isSecureTextEntry = true
        passwordTxtField.textContentType = .oneTimeCode
        
        confirmPasswordTxtField.returnKeyType = .done
        confirmPasswordTxtField.isSecureTextEntry = true
        confirmPasswordTxtField.textContentType = .oneTimeCode
        
        
        //Button view hidden
        
        let userAccountExist = UserAuthentication.shared.isUserAccountCreated()
        
        if userAccountExist{
            
            hideVerifyAccountView()
            
        }else{
            
            hideCreateAccontView()
            
        }
        
        
        //Test Purpose - Start
//        fullNameTxtField.text = "Adwik V V"
//        emailAddressTxtField.text = "adwiksajeev@gmail.com"
//        passwordTxtField.text = "adwikvvv"
//        confirmPasswordTxtField.text = "adwikvvv"
        //Test Purpose - End
        
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
    
    
    private func validateInputs() -> (email: String, password: String, fullName: String)? {
        
        guard
            let fullName = fullNameTxtField.text ,
            let email = emailAddressTxtField.text,
            let password = passwordTxtField.text,
            let confirmPassword = confirmPasswordTxtField.text
                
        else { return nil }
        
        guard !fullName.isEmpty else {
            CustomAlertView.showCustomErrorMessage(titleMsg: "Please enter your name")
            return nil
        }
        
        
        guard Common.isValidEmail(email) else {
            emailAddressTxtField.text = ""
            CustomAlertView.showCustomErrorMessage(titleMsg: "Please enter a valid email address")
            return nil
        }
        
        
        guard password.count >= 6 else {
            passwordTxtField.text = ""
            CustomAlertView.showCustomErrorMessage(titleMsg: "Password must contain atleast 6 characters")
            return nil
        }
        
        
        guard confirmPassword == password else {
            confirmPasswordTxtField.text = ""
            CustomAlertView.showCustomErrorMessage(titleMsg: "Confirm password doesn't match")
            return nil
        }
        
        return (email , password, fullName)
        
    }
    
    
    private func hideVerifyAccountView() {
        createAccontView.isHidden = false
        createAccontViewHeightConstraint.constant = 110
        
        verifyAccontView.isHidden = true
        verifyAccontViewHeightConstraint.constant = 0
    }
    
    
    
    
    private func hideCreateAccontView() {
        createAccontView.isHidden = true
        createAccontViewHeightConstraint.constant = 0
        
        verifyAccontView.isHidden = false
        verifyAccontViewHeightConstraint.constant = 110
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


extension RegisterViewController {
    
    //MARK: - Auth Functions
    
    
    private func createAccountCallForLoginPurpose() {
        
        guard let credentials = validateInputs() else { return }
        
//        Firebase adds new user
        UserAuthentication.shared.loginUserFireBaseCall(email: credentials.email, password: credentials.password) { loginSuccess in
            
            if loginSuccess {
                
                FireStoreManager.shared.saveUserData(fullName: credentials.fullName, email: credentials.email) { dataSaved in
                    
                    if dataSaved{
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")as! HomeViewController
                        
                        homeVc.modalTransitionStyle = .crossDissolve
                        homeVc.modalPresentationStyle = .fullScreen
                        self.present(homeVc, animated: true)
                    }else{
                        print("Data saving error")
                    }
                    
                }
                
                
            }else{
                
                print("Stay in the same page")
                
            }
            
        }
        
        
    }
    
    
    private func verifyAccountCallForCreatingNewAccountPurpose() {
        
        guard let credentials = validateInputs() else { return }
        
        //Firebase verify the new user email
        UserAuthentication.shared.createAccountFirebaseCall(email: credentials.email, password: credentials.password) { [self] accountCreated in
            
            if accountCreated {
                
                hideVerifyAccountView()
                
            }else{
                
                hideCreateAccontView()
                
            }
            
        }
        
    }
    
    
}


extension RegisterViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case fullNameTxtField:
            emailAddressTxtField.becomeFirstResponder()
            
        case emailAddressTxtField:
            passwordTxtField.becomeFirstResponder()
            
        case passwordTxtField:
            confirmPasswordTxtField.becomeFirstResponder()
            
        case confirmPasswordTxtField:
            textField.resignFirstResponder()
            
        default:
            return false
            
        }
        
        return false
        
    }
    
    
}
