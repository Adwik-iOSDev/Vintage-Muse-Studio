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
    

}



//MARK: - Private Functions

extension RegisterViewController {
    
    private func initialUIchanges() {
        
        view.backgroundColor = .bg
        
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
        }
        
        scrollView.bounces = false
        
    }
    
    
}

