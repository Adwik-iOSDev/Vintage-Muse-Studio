//
//  FireStoreManager.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 13/06/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth



final class FireStoreManager {
    
    static let shared = FireStoreManager()
    
    private init() {}
    
    let fireBaseAuth = Auth.auth()
    let db = Firestore.firestore()
    
    
    //MARK: - Save
    
    //Save user data
    func saveUserData(
        
        fullName: String,
        email: String,
        completion: ((Bool) -> Void)? = nil
        
    )
    
    {
        
        guard let userId = fireBaseAuth.currentUser?.uid else {
            completion?(false)
            return
        }
        
        db.collection(FireStoreCollectionKey.usersKey).document(userId).setData([
            "fullName": fullName,
            "email": email,
            "createdAt": FieldValue.serverTimestamp()
            
        ]) { error in
            
            if let error = error {
                completion?(false)
                CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
                return
            }
            
            completion?(true)
            
        }
        
    }
    
    
    
    //MARK: - Fetch
    
    
    //Fetch user data
    func fetchUserData(completion: @escaping ([String: Any]?) -> Void) {
        
        
        guard let userId = fireBaseAuth.currentUser?.uid else {
            completion(nil)
            return
        }
        
        
        db.collection(FireStoreCollectionKey.usersKey)
            .document(userId)
            .getDocument { snapShot, error in
                
                
                if let error = error {
                    
                    completion(nil)
                    CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
                    
                }
                
                completion(snapShot?.data())
                
                
            }
        
        
    }
    
    
    
    //MARK: - Update
    
    
    //Update user data
    func updateExistingUserData() {
        
        
        guard let userId = fireBaseAuth.currentUser?.uid else {
            return
        }
        
        db.collection(FireStoreCollectionKey.usersKey)
            .document(userId)
            .updateData([:]) { error in
                
                if let error = error {
                    CustomAlertView.showCustomErrorMessage(titleMsg: error.localizedDescription)
                }
                
                print("user data updated")
                
            }
        
    }
    
    
}
