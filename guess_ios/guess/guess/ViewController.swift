//
//  ViewController.swift
//  guess
//
//  Created by O_Kenta on 2017/10/21.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var class_sheet: UICollectionView!
    //曜日の数
    let row: CGFloat = 5;
    //何限まであるかの数
    let colum: CGFloat = 5;
    //marginの最小単位
    let margin: CGFloat = 8;
    //cell_sectionの初期値を設定
    var cell_section = 0;
    //cell_rowの初期値を設定
    var cell_row = 0;
    
    func open_DB() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
//        let fetchData = try! context.fetch(fetchRequest)
        return
    }
    
    //読み込み時に行う処理
    override func viewDidLoad() {
        //データベースからの呼び出し
        open_DB()
 
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //画面表示時毎におこなう処理
    override func viewWillAppear(_ animated: Bool) {
        //データベースの呼び出し
        open_DB()
        
        //時間割の表示のリフレッシュ
        self.class_sheet.reloadData()
        
//データベース確認用のソース
//        if(!fetchData.isEmpty){
//
//            for j in 0..<fetchData.count{
//
//                print("No.\(j)")
//                print(fetchData[j].title)
//                print(fetchData[j].room)
//                print(fetchData[j].colum)
//                print(fetchData[j].row)
//            }
//
//        }
//データベース確認用のソースここまで

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "Cell" はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
       let cell_row = (indexPath as NSIndexPath).row
        let cell_section = (indexPath as NSIndexPath).section
        
        //rowとcolumでデータを検索する設定をする
        let predicate = NSPredicate(format:"(row == %d && colum == %d)", cell_row, cell_section )
        
        //データの取得のリクエストを作る
        fetchRequest.predicate = predicate
        //データを取得する
        let fetchData = try! context.fetch(fetchRequest)
        
        print("表示！！！")
        let label_title = testCell.contentView.viewWithTag(2) as! UILabel
        let label_row = testCell.contentView.viewWithTag(3) as! UILabel
        let label_section = testCell.contentView.viewWithTag(4) as! UILabel
        
        if(!fetchData.isEmpty){
            //過去にデータが作成されていた場合
            //データの書き換えをおこなう（複数ある場合を想定してfor文になっている）
            for i in 0..<fetchData.count{
                label_title.text = fetchData[i].title
                label_row.text = String(fetchData[i].row)
                label_section.text = String(fetchData[i].colum)
            }
        } else {
            label_title.text = nil
            label_row.text = nil
            label_section.text = nil
        }

        //角丸にする
        testCell.layer.cornerRadius = 5.0
        //セルの背景色
        testCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.25)
        return testCell
    }
    
    // Screenサイズに応じたセルサイズを返す　UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 横に5つの、縦に5つのCellを入れることを想定して、多少のマージンを入れる
        // セルの横のサイズの計算
        let cellSize_w:CGFloat = (self.view.frame.size.width-56)/(row)-row*2;
        //セルの縦のサイズの計算（スクロールさせないためにUICollectionViewの上下のマージン分を除く）
        let cellSize_h:CGFloat = (self.view.frame.size.height-(132))/(colum)-colum*2;
        // 計算したセルのwidth,heightを返り値にする
        return CGSize(width: cellSize_w, height: cellSize_h)
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {

        cell_section = (indexPath as NSIndexPath).section
        cell_row = (indexPath as NSIndexPath).row

            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toSubViewController",sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSubViewController") {
            let subVC: SubViewController = (segue.destination as? SubViewController)!
            // SubViewController のsectionとrowを渡す
            subVC.section = cell_section;
            subVC.row = cell_row;
        }
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

