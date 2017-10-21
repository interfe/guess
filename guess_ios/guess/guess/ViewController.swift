//
//  ViewController.swift
//  guess
//
//  Created by O_Kenta on 2017/10/21.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    let photos = ["やまだ", "No.2","No.3","No.4","No.5"];
    //曜日の数
    let row: CGFloat = 5;
    //何軒まであるかの数
    let colum: CGFloat = 5;
    //marginの最小単位
    let margin: CGFloat = 8;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "Cell" はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath)
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = testCell.contentView.viewWithTag(2) as! UILabel
        label.text = photos[(indexPath as NSIndexPath).row]
        
        //セルの背景色
        testCell.backgroundColor = UIColor.cyan
        
        
        return testCell
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横に5つの、縦に5つのCellを入れることを想定して、多少のマージンを入れる
        // セルの横のサイズの計算
        let cellSize_w:CGFloat = (self.view.frame.size.width)/(row)-row*3;
        //セルの縦のサイズの計算（スクロールさせないためにUICollectionViewの上下のマージン分を除く）
        let cellSize_h:CGFloat = (self.view.frame.size.height-(margin*12+margin*3))/(colum)-colum*3;
        // 計算したセルのwidth,heightを返り値にする
        return CGSize(width: cellSize_w, height: cellSize_h)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //int型に変換
        let a:Int = Int(colum)
        // section数之数
        return a;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //int型に変換
        let a:Int = Int(row)
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return a;
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

