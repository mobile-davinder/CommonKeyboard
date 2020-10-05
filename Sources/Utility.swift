//
//  Utility.swift
//  CommonKeyboard
//
//  Created by Kaweerut Kanthawong on 8/9/2019.
//  Copyright © 2019 Kaweerut Kanthawong. All rights reserved.
//

import UIKit

internal protocol CKUtilityProtocol {
    var currentResponder: UIResponder? { get }
    var currentWindow: UIWindow? { get }
    var topViewController: UIViewController? { get }
    var currentScrollContainer: UIScrollView? { get }
}

internal class CKUtility: CKUtilityProtocol {
    
    internal var currentResponder: UIResponder? {
        return UIResponder.current
    }
    
    internal var currentWindow: UIWindow? {
        return ((currentResponder as? UIView)?.window ?? UIApplication.shared.keyWindow)
    }
    
    internal var topViewController: UIViewController? {
        return currentWindow?.getTopViewController()
    }
    
    internal var currentScrollContainer: UIScrollView? {
        if let topVC = topViewController
            , let vc = topVC as? CommonKeyboardContainerProtocol {
            return vc.scrollViewContainer
        }
        
        guard let responsederSuperview = (currentResponder as? UIView)?.superview else {
            return nil
        }
        
        var superview: UIView? = responsederSuperview
        var scrollView: UIScrollView?
        while (superview != nil) {
            if let view = superview as? UIScrollView {
                scrollView = view
            }
            superview = superview?.superview
        }
        
        return scrollView
    }
}

fileprivate extension UIWindow {
    func getTopViewController(_ baseViewController: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = baseViewController as? UINavigationController {
            return getTopViewController(nav.visibleViewController)
        } else if let tab = baseViewController as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(selected)
        } else if let presented = baseViewController?.presentedViewController {
            return getTopViewController(presented)
        }
        return baseViewController
    }
}

fileprivate extension UIResponder {
    private weak static var _currentFirstResponder: UIResponder? = nil
    
    static var current: UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }
    
    @objc func findFirstResponder(sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
}
