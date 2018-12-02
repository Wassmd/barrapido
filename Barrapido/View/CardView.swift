//
//  CardView.swift
//  Barrapido
//
//  Created by Mohammed Wasimuddin on 02/12/18.
//  Copyright © 2018 Wasim. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    
    @IBInspectable var shadowOffSetWidth: Int = 0
    @IBInspectable var shadowOffSetHeight: Int = 1
    
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
        
    }
}


@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
