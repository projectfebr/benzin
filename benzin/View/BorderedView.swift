//
//  BorderedView.swift
//  benzin
//
//  Created by Александр Болотов on 04.01.2021.
//

import UIKit

@IBDesignable
class BorderedView: UIView {
    
    @IBInspectable var borderColor: UIColor = DefaultValues.borderColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = DefaultValues.borderWidth {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = DefaultValues.cornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private struct DefaultValues {
        static let cornerRadius: CGFloat = 14.0
        static let borderWidth: CGFloat = 2.0
        static let borderColor: UIColor = #colorLiteral(red: 0.9261129498, green: 0.3526465893, blue: 0.1146638468, alpha: 1)
    }

}
