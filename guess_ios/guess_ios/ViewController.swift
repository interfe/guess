//
//  ViewController.swift
//  guess_ios
//
//  Created by O_Kenta on 2017/10/14.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    // サムネイル画像の名前
    let photos = ["時間割1", "時間割2","時間割3","時間割4","時間割5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // "Cell" はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                               for: indexPath)
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = testCell.contentView.viewWithTag(2) as! UILabel
        label.text = photos[(indexPath as NSIndexPath).row]
        
        return testCell
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横に２つのCellを入れることを想定して、多少のマージンを入れる
        let cellSize_w:CGFloat = (self.view.frame.size.width)/5 - 10
        let cellSize_h:CGFloat = (self.view.frame.size.height - 80)/5 - 10
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize_w, height: cellSize_h)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // section数は１つ
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 5;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

