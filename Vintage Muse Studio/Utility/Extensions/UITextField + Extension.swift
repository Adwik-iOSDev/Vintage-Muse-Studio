//
//  UITextField + Extension.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 11/06/26.
//

import Foundation
import UIKit

//MARK: - Next work here

extension UITextField {
    
    func applyPlaceholderChanges(
        placeholderText: String,
        colorString: String,
        alpha: CGFloat = 1.0,
        fontSize: CGFloat? = nil,
        fontWeight: UIFont.Weight? = nil
    )
    
    {
        
        
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .foregroundColor: UIColor(named: colorString)!.withAlphaComponent(alpha),
                .font: UIFont.systemFont(ofSize: fontSize ?? 10, weight: fontWeight ?? .regular)
            ]
        )
        
    }
    
}
