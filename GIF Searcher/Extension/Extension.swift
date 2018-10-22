//
//  Extension.swift
//  GIF Searcher
//
//  Created by Vlad Birukov on 20/10/2018.
//  Copyright © 2018 Vlad Birukov. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationVC = base as? UINavigationController {
            return topViewController(base: navigationVC.visibleViewController)
        }
        
        if let tabBarViewController = base as? UITabBarController {
            let moreNavigationController = tabBarViewController.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tabBarViewController.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

extension UIView {
    func showToast(message : String) {
        let font = UIFont.systemFont(ofSize: 16)
        let toastLabel = UILabel()
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = font
        toastLabel.text = message
        
        let textSize = (message as NSString).size(withAttributes: [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):  font])
        var x = self.center.x - textSize.width / 2
        let labelWidth = min(textSize.width, self.frame.width - 40)
        
        toastLabel.frame =  CGRect(x: x, y: self.frame.height - 150, width: labelWidth + 50, height: textSize.height + 30)
        let oldFrame = toastLabel.frame
        
        toastLabel.center = self.center
        x = toastLabel.frame.origin.x
        toastLabel.frame = CGRect(x: x, y: oldFrame.origin.y, width: oldFrame.size.width, height: oldFrame.size.height)
        
        
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = toastLabel.frame.size.height / 2
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, delay: 0.01, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
