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
    
    func addShadow(color: CGColor = UIColor.black.cgColor,
                   radius: CGFloat = 2.5,
                   opacity: Float = 0.6,
                   offset: CGSize = CGSize(width: 0.5, height: 1.5),
                   masksToBounds: Bool = false
    ) {
        // Set the color of the shadow layer
        layer.shadowColor = color
        // Set the radius of the shadow layer
        layer.shadowRadius = radius
        // Set the opacity of the shadow layer (1 = fully opaque, 0 = fully transparent)
        layer.shadowOpacity = opacity
        /* Offset refers to where and to what extent a shadow is offset from the view (in points)
         The default offset size is (0, -1), which indicates a shadow one point above the text. */
        layer.shadowOffset = offset
        // Prevent layers of view from extending beyond the view
        layer.masksToBounds = masksToBounds
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
    func presentAlert(alert: AlertModel, actions: AlertActionModel...) {
        
        let isPad = UIDevice.current.isPad
        
        let alert = UIAlertController(title: alert.title,
                                      message: alert.message,
                                      // ensures that if device is iPad, an actionSheet will not be presented
                                      preferredStyle: isPad ? .alert : alert.style)
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
    func addActions(_ actions: AlertActionModel...) {
        for action in actions {
            addAction(UIAlertAction(title: action.title,
                                    style: action.style,
                                    handler: nil))
        }
    }
    
    func addTextField(placeholder: String) {
        addTextField { textField in
            textField.placeholder = placeholder
        }
    }
    
    func addPickerView(delegateAndDataSource: (UIPickerViewDelegate & UIPickerViewDataSource)) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: Constants.width, height: Constants.width))
        pickerView.delegate = delegateAndDataSource
        pickerView.dataSource = delegateAndDataSource
        vc.view.addSubview(pickerView)
        setValue(vc, forKey: "contentViewController")
    }
}

// MARK: - UIDevice

extension UIDevice {
    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}

// MARK: - Int

extension Int {
    
    func inMinutes() -> Int {
        return self / 60
    }
    
    func inSeconds() -> Int {
        return self * 60
    }
}
