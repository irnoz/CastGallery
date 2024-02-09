//
//  UIView+Constraints.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 09.02.24.
//

import UIKit

extension UIView {
    
    func setConstraints(
        top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
        pTop: CGFloat = .zero, pBottom: CGFloat = .zero, pLeft: CGFloat = .zero, pRight: CGFloat = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = true
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: pTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: pBottom).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: pLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: pRight).isActive = true
        }
    }
    
    func fillSuperView(widthPadding: CGFloat = .zero) {
        guard let superview = self.superview else {
            return
        }
        
        setConstraints(
            top: superview.topAnchor, bottom: superview.bottomAnchor,
            left: superview.leftAnchor, right: superview.rightAnchor,
            pTop: widthPadding, pBottom: widthPadding, pLeft: widthPadding, pRight: widthPadding
        )
    }
}
