//
//  custom.swift
//  guess
//
//  Created by O_Kenta on 2017/10/21.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//

import UIKit

class MyRoundButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.darkGray, for: [.selected, .highlighted])
        setTitleColor(.black, for: .selected)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        tintColor = .clear
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
    
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    fileprivate func updateBackgroundColor() {
        if !isSelected && !isHighlighted {
            backgroundColor = .clear
        } else if !isSelected && isHighlighted {
            backgroundColor = .lightGray
        } else {
            backgroundColor = .white
        }
    }
}
