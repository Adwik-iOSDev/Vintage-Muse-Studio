//
//  HomeViewController.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 13/06/26.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

    @IBAction func didSignOutButtonTapped(_ sender: UIButton) {
        
        UserAuthentication.shared.logOutUser { logOutSuccess in
            
            if logOutSuccess{
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let loginVc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
                
                loginVc.modalTransitionStyle = .crossDissolve
                loginVc.modalPresentationStyle = .fullScreen
                self.present(loginVc, animated: true)
            }else{
                
                print("Stay in the same page")
                
            }
            
        }
        
    }
    

}
