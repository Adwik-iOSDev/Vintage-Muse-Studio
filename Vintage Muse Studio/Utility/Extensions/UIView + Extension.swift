//
//  UIView + Extension.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 09/06/26.
//

import Foundation
import UIKit


extension UIView {
    
    
    func applyCustomGradient(top: UIColor? = nil, middle: UIColor? = nil, bottom: UIColor? = nil) {
        
        let gradient = CAGradientLayer()
        
        // ✅ Default theme colors if nil is passed
        
        let topColor = top ?? VMThemeColor.AppMainThemeColor.gold
        let middleColor = middle ?? VMThemeColor.AppMainThemeColor.charcoal
        let bottomColor = bottom ?? VMThemeColor.AppMainThemeColor.black
        
        gradient.colors = [
            topColor.withAlphaComponent(0.5).cgColor,
            middleColor.withAlphaComponent(0.75).cgColor,
            bottomColor.withAlphaComponent(1).cgColor,
            
        ]
        
        gradient.locations = [
            0.0,
            0.45,
            1.0
        ]

    
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.frame = bounds
        
        layer.insertSublayer(gradient, at: 0)
        
        
    }
    
}

extension [UIView] {
    
    
    func applyBorder(color: UIColor,
                     alpha: CGFloat? = nil,
                     borderWidth: CGFloat,
                     cornerRadius: CGFloat? = nil
    ) {
        
        let borderColor = color.withAlphaComponent(alpha ?? 1.0).cgColor
        
        forEach {
            $0.layer.borderColor = borderColor
            $0.layer.borderWidth = borderWidth
            $0.layer.cornerRadius = cornerRadius ?? 0.0
            $0.clipsToBounds = true
        }
        
    }
    
    
}


