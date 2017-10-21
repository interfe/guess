//
//  Button_Custom.swift
//  guess
//
//  Created by O_Kenta on 2017/10/21.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//

import UIKit

// MARK: カスタムボタンの定義
@IBDesignable
class CustomButton: UIButton {
    
    // 角丸の半径(0で四角形)
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    // 枠
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    // バックグラウンドカラー
    @IBInspectable var nonHighlightedBackgroundColor :UIColor?
    @IBInspectable var highlightedBackgroundColor :UIColor?
    
    override func drawRect(rect: CGRect) {
        // 角丸
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        // 枠線
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = borderWidth
        
        super.drawRect(rect)
    }
    
    // バックグラウンドカラー
    override var highlighted :Bool {
        didSet {
            if highlighted {
                self.backgroundColor = highlightedBackgroundColor
            }
            else {
                self.backgroundColor = nonHighlightedBackgroundColor
            }
        }
    }
}

// MARK: カスタムラベルの定義
@IBDesignable class CustomLabel: UILabel {
    
    // 角丸の半径(0で四角形)
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    // 枠
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func drawRect(rect: CGRect) {
        // 角丸
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        // 枠線
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = borderWidth
        
        super.drawRect(rect)
    }
}

// MARK: カスタムテキストビューの定義
@IBDesignable class CustomTextView: UITextView {
    
    // 角丸の半径(0で四角形)
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    // 枠
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func drawRect(rect: CGRect) {
        // 角丸
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        // 枠線
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = borderWidth
        
        super.drawRect(rect)
    }
}
