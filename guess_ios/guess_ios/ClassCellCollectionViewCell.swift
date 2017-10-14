//
//  ClassCellCollectionViewCell.swift
//  guess_ios
//
//  Created by O_Kenta on 2017/10/14.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//

import UIKit

class ClassCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // UILabelを生成
        textLabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textLabel.textAlignment = NSTextAlignment.center
        // Cellに追加
        self.addSubview(textLabel!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
}
