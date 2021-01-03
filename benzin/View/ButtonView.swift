//
//  ButtonView.swift
//  benzin
//
//  Created by Александр Болотов on 04.01.2021.
//

import UIKit

@IBDesignable
class ButtonView: UIButton {

    @IBInspectable var color: UIColor = DefaultValues.color {
        didSet {
            layer.backgroundColor = color.cgColor
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
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = color.cgColor
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
        static let color: UIColor = #colorLiteral(red: 0.9261129498, green: 0.3526465893, blue: 0.1146638468, alpha: 1)
    }
}
