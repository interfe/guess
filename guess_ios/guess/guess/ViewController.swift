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
    
    

    let class_name = ["やまだ", "No.2","No.3","No.4","No.5"];
    //曜日の数
    let row: CGFloat = 5;
    //何軒まであるかの数
    let colum: CGFloat = 5;
    //marginの最小単位
    let margin: CGFloat = 8;
    
    
    var select_name = "やまだ";
    var cell_section = 0;
    var cell_row = 0;
    
    
    override func viewDidLoad() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            for i in 0..<fetchData.count{
                let entity = NSEntityDescription.entity(forEntityName: "Lesson", in: context)
                let lesson = NSManagedObject(entity:entity!,insertInto:context) as! Lesson
                lesson.title = fetchData[i].title
                lesson.room = fetchData[i].room
                lesson.row = fetchData[i].row
                lesson.colum = fetchData[i].colum
                
                print("No.\(i)")
                print(lesson.title)
                print(lesson.room)
                print(lesson.colum)
                print(lesson.row)
            }
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
      ///  getData()
        // class_sheetを再読み込みする
        class_sheet.reloadData()
    }
    
    
//
//    func getData() {
//        // データ保存時と同様にcontextを定義
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do {
//            // CoreDataからデータをfetchしてtasksに格納
//            let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
//            lesson = try context.fetch(fetchRequest)
//
//            // tasksToShow配列を空にする。（同じデータを複数表示しないため）
//            for key in tasksToShow.keys {
//                tasksToShow[key] = []
//            }
//            // 先ほどfetchしたデータをtasksToShow配列に格納する
//            for task in tasks {
//                tasksToShow[task.category!]?.append(task.name!)
//            }
//        } catch {
//            print("Fetching Failed.")
//        }
//    }
    
    
    
    
    
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "Cell" はストーリーボードで設定したセルのID
        let testCell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath)
        
        // Tag番号を使ってLabelのインスタンス生成
        let label = testCell.contentView.viewWithTag(2) as! UILabel
        label.text = class_name[(indexPath as NSIndexPath).row]
        let label_section = testCell.contentView.viewWithTag(3) as! UILabel
        label_section.text = String((indexPath as NSIndexPath).section);
        let label_row = testCell.contentView.viewWithTag(4) as! UILabel
        label_row.text = String((indexPath as NSIndexPath).row);
        
    
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
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let name = class_name[(indexPath as NSIndexPath).row]
        cell_section = (indexPath as NSIndexPath).section
        cell_row = (indexPath as NSIndexPath).row
        print(name)
        print((indexPath as NSIndexPath).row)
        print((indexPath as NSIndexPath).section)
            // SubViewController へ遷移するために Segue を呼び出す
            select_name = name;
        
            performSegue(withIdentifier: "toSubViewController",sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSubViewController") {
            let subVC: SubViewController = (segue.destination as? SubViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            subVC.select_name = select_name;
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

