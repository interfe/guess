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
        let fetchRequest_lesson:NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let fetchRequest_setting:NSFetchRequest<Setting> = Setting.fetchRequest()
        
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
        let fetchRequest_lesson:NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let fetchRequest_setting:NSFetchRequest<Setting> = Setting.fetchRequest()

       let cell_row = (indexPath as NSIndexPath).row
        let cell_section = (indexPath as NSIndexPath).section
        
        //rowとcolumでデータを検索する設定をする
        let predicate = NSPredicate(format:"(row == %d && colum == %d)", cell_row, cell_section )
        
        //データの取得のリクエストを作る
        fetchRequest_lesson.predicate = predicate
        //データを取得する
        
        let fetchData_lesson = try! context.fetch(fetchRequest_lesson)
        let fetchData_setting = try! context.fetch(fetchRequest_setting)
        
        
      //  print("表示！！！")
        let label_title = testCell.contentView.viewWithTag(2) as! UILabel
        let label_row = testCell.contentView.viewWithTag(3) as! UILabel
        let label_section = testCell.contentView.viewWithTag(4) as! UILabel
        var absense_rate = 0.8

        if(!fetchData_lesson.isEmpty){
            //過去にデータが作成されていた場合
            //データの書き換えをおこなう（複数ある場合を想定してfor文になっている）

            for i in 0..<fetchData_lesson.count{
                label_title.text = fetchData_lesson[i].title
                label_row.text = String(fetchData_lesson[i].row)
                label_section.text = String(fetchData_lesson[i].colum)
                //以下テスト用
                //absense_rate = 0.2 * Double(fetchData_lesson[i].row)
                //欠席数/欠席可能数　によって色を出し分け
               // absense_rate = 1 - Double(fetchData_lesson[i].absence/fetchData_setting[i].no_absence)
                switch absense_rate {
                // 青信号
                case 0.7...1.0:
                      testCell.backgroundColor = UIColor(red: 0.416, green: 0.890, blue: 0.545, alpha: 0.85)
                    
                case 0.3..<0.7:
                // 黄色信号
                    testCell.backgroundColor = UIColor(red: 0.965, green: 0.792, blue: 0.373, alpha: 0.85)

                case 0.0..<0.3:
                //　赤信号
                     testCell.backgroundColor = UIColor(red: 0.890, green: 0.286, blue: 0.239, alpha: 0.85)
                case ..<0:
                //  DEAD 黒
                     testCell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
                    
                default:
                // セルの背景色
                   testCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.25)
                }

            }
        } else {
            label_title.text = nil
            label_row.text = nil
            label_section.text = nil
            // セルの背景色
            testCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.25)
        }

        //角丸にする
        testCell.layer.cornerRadius = 5.0
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

