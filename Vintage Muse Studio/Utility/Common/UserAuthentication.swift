//
//  UserAuthentication.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 13/06/26.
//

import Foundation
import FirebaseAuth

class UserAuthentication {
    
    
    private let fireBaseAuth = Auth.auth()
    
    static let shared = UserAuthentication()
    
    
    //User Login
    func loginUserFireBaseCall(email: String, password: String, completion: @escaping(Bool) -> Void) {
        
        
        fireBaseAuth.signIn(withEmail: email, password: password) { [self] result, error in
            
            if let loginError = error  {
                completion(false)
                CustomAlertView.showCustomErrorMessage(titleMsg: loginError.localizedDescription)
                return
            }
            
            if let user = fireBaseAuth.currentUser {
                
                if user.isEmailVerified{
                    completion(true)
                    CustomAlertView.showCustomSuccessMessage(titleMsg: "Login success")
                }else{
                    completion(false)
                    CustomAlertView.showCustomErrorMessage(titleMsg: "Please verify email to login")
                }
                
            }else{
                completion(false)
            }
            
            
            
        }
        
    }
    
    
    //Forgot password call
    func forgotPasswordCall(email: String) {
        
        fireBaseAuth.sendPasswordReset(withEmail: email) { error in
            
            if let error = error {
                CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
                return
            }
            
            CustomAlertView.showCustomSuccessMessage(titleMsg: "Reset password email sent")
            
        }
        
    }
    
    
    //Create new account
    func createAccountFirebaseCall(
        email: String,
        password: String,
        completion: ((Bool) -> Void)? = nil)
    
    {
        
        
        fireBaseAuth.createUser(withEmail: email, password: password) { [self]  result, error in
            
            
            if let error = error {
                CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
                completion?(false)
                return
            }
            
            print("Account successfully created")
            completion?(true)
            
            verifyEmail()
            
            
        }
        
    }
    
    
    //Verify email for creating account
    func verifyEmail() {
        
        
        fireBaseAuth.currentUser?.sendEmailVerification {  error in
            
            if let error = error {
                CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
                return
            }
            
            CustomAlertView.showCustomSuccessMessage(titleMsg: "Verification Email Sent")
            
        }
        
        
    }
    
    
    //Logout user
    func logOutUser(completion: ((Bool) -> Void)? = nil) {
        
        do {
            
            try fireBaseAuth.signOut()
            completion?(true)
            print("Log out success")
            
        }catch let error {
            
            completion?(false)
            CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
            
        }
        
    }
    
    
    func isUserAccountCreated() -> Bool {
        
        if fireBaseAuth.currentUser != nil {
            return true
        }else{
            return false
        }
        
    }
    
}
