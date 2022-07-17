//
//  Extensions.swift
//  MVVM-ToDo-Assignment
//
//  Created by David Jabech on 7/15/22.
//

import UIKit

    // MARK: - UIView

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
    func centerY(in superView: UIView) {
        center.y = superView.center.y
    }
    
    func centerX(in superView: UIView ) {
        center.x = superView.center.x
    }
    
    func center(in superView: UIView) {
        center = superView.center
    }

    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
    
    var leading: CGFloat {
        return frame.origin.x
    }
    
    var trailing: CGFloat {
        return leading + width
    }
}

    // MARK: - UIStackView

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}

    // MARK: - UIViewController

extension UIViewController {
    func presentAlert(alert: AlertModel, actions: [AlertActionModel]) {
        let alert = UIAlertController(title: alert.title,
                                      message: alert.message,
                                      preferredStyle: alert.style)
        for action in actions {
            alert.addAction(UIAlertAction(title: action.title,
                                          style: action.style,
                                          handler: action.handler))
        }
        present(alert, animated: true)
    }
    
    func add(_ controller: UIViewController, for childView: UIView) {
        addChild(controller)
        childView.addSubview(controller.view)
        controller.view.frame = childView.bounds
        controller.didMove(toParent: self)
    }
    
    func removeChildren() {
        children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
}

    // MARK: - UIAlertController

extension UIAlertController {
    func addAction(_ action: AlertActionModel) {
        addAction(UIAlertAction(title: action.title,
                                style: action.style,
                                handler: nil))
    }
}
