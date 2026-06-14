//
//  HomeViewController.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 13/06/26.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserData()
        
    }
    

    @IBAction func didSignOutButtonTapped(_ sender: UIButton) {
        
        callSignOut()
        
    }
    

}


//MARK: - Private Functions

extension HomeViewController {
    
    
    func loadUserData() {
        
        FireStoreManager.shared.fetchUserData { data in
            
            
            guard let userData = data else {
                return
            }
            
            DispatchQueue.main.async {
                
                let fullName = userData["fullName"] as! String
                let email = userData["email"] as! String
                let createdAt = userData["createdAt"]!
                
                
                self.titleLbl.text = "Hi \(fullName), your email id : \(email), Created at ; \(createdAt)"
                
            }
            
        }
        
    }
    
    
}



//MARK: - Auth Functions

extension HomeViewController {
    
    
    private func callSignOut() {
        
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
