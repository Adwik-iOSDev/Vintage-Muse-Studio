//
//  CustomAlertView.swift
//  Vintage Muse Studio
//
//  Created by Adwik on 12/06/26.
//

import Foundation
import UIKit
import SwiftMessages


class CustomAlertView: MessageView {
    
    
    private static func showAlertMessage(
        titleMsg: String,
        borderColor: UIColor,
        icon: String,
        iconTintColor: UIColor
    )
    
    {
        
        guard let view = try! SwiftMessages.viewFromNib(named: "CustomAlertView") as? CustomAlertView else { return }
        
        //Design
        view.backgroundView.layer.borderColor = borderColor.cgColor
        view.backgroundView.layer.borderWidth = 1
        view.backgroundView.layer.cornerRadius = 20
        
        view.iconImageView?.image = UIImage(systemName: icon)
        view.iconImageView?.layer.backgroundColor = UIColor(named: VMThemeColor.bgColor)?.cgColor
        view.iconImageView?.tintColor = iconTintColor //redAlertColor
        
        
        //Data
        view.titleLabel?.text = titleMsg
        
        var config = SwiftMessages.Config()
        
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: 2)
        config.dimMode = .gray(interactive: true)
        
        SwiftMessages.show(config: config, view: view)
        
    }
    
    
    //Error Alert
    static func showCustomErrorMessage(titleMsg: String, bodyMsg: String? = nil) {
        
        
        showAlertMessage(
            titleMsg: titleMsg,
            borderColor: .red,
            icon: "xmark.circle.fill",
            iconTintColor: .redAlert
        )
        
        
    }
    
    
    //Success Alert
    static func showCustomSuccessMessage(titleMsg: String, bodyMsg: String? = nil) {
        
        
        showAlertMessage(
            titleMsg: titleMsg,
            borderColor: .greenBg,
            icon: "checkmark.circle.fill",
            iconTintColor: .greenBg
        )
        
        
    }
    
    
}
