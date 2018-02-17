//
//  SubViewController.swift
//  guess
//
//  Created by O_Kenta on 2017/10/21.
//  Copyright © 2017年 O_Kenta. All rights reserved.
//

import UIKit
import CoreData

class SubViewController: UIViewController {

    @IBOutlet weak var class_name: UINavigationItem!
    @IBOutlet weak var buttan_input: UIButton!
    @IBOutlet weak var class_input: UITextField!
    @IBOutlet weak var Lesson_delete: UIButton!
    @IBOutlet weak var delete_all: UIButton!
    
    var section = 0;
    var row = 0;
    

///授業の情報を入力する
@IBAction func class_input(_ sender: UIButton) {
//入力された文字列のインプット
        let lesson_name = class_input.text
//入力されていなかった場合は処理はおこなわずに、戻る
        if lesson_name == "" {
            dismiss(animated: true, completion: nil)
            return
        }


    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
    
    //rowとcolumでデータを検索する設定をする
    let predicate = NSPredicate(format:"(row == %d && colum == %d)", row, section )
     //データの取得のリクエストを作る
    fetchRequest.predicate = predicate
     //データを取得する
    let fetchData = try! context.fetch(fetchRequest)
    
    print("フェッチdata")
    print(fetchData)

    
    if(!fetchData.isEmpty){
//過去にデータが作成されていた場合
        print("更新！！！")
//データの書き換えをおこなう（複数ある場合を想定してfor文になっている）
        for i in 0..<fetchData.count{
//各項目のデータを書き換える
            fetchData[i].title = lesson_name;
            fetchData[i].row = Int64(row);
            fetchData[i].colum = Int64(section);
        }
//データを保存する
        do{
            try context.save()
            dismiss(animated: true, completion: nil)
        }catch{
            print(error)
            dismiss(animated: true, completion: nil)
        }
    }
//過去に作成されていなかった場合
        else{
//新しくデータの追加
        do{
            print("新しくついか!!")
//データベース全体を取得
            let lesson = Lesson(context:context)
//データを追加
            lesson.title = lesson_name
            lesson.row = Int64(row)
            lesson.colum = Int64(section)
            try context.save()
            dismiss(animated: true, completion: nil)
        }catch{
            print(error)
            dismiss(animated: true, completion: nil)
        }
        }
    
}
    
///削除ボタン
@IBAction func delete_button(_ sender: UIButton) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
    //rowとcolumでデータを検索する設定をする
    let predicate = NSPredicate(format:"(row == %d && colum == %d)", row, section )
    //データの取得のリクエストを作る
    fetchRequest.predicate = predicate
    //データを取得する
    let fetchData = try! context.fetch(fetchRequest)

                if(!fetchData.isEmpty){
                    print("delete!!")
                    for i in 0..<fetchData.count{
                        let deleteObject = fetchData[i] as Lesson
                        context.delete(deleteObject)
                    }
                    do{
                        try context.save()
                         dismiss(animated: true, completion: nil)
                    }catch{
                        print(error)
                         dismiss(animated: true, completion: nil)
                    }
                }
                else{
                    dismiss(animated: true, completion: nil)
                    
    }
    }
    
    ///すべて削除button
    @IBAction func delete_all_button(_ sender: Any) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print("delete!!")
            for i in 0..<fetchData.count{
                let deleteObject = fetchData[i] as Lesson
                context.delete(deleteObject)
            }
            do{
                try context.save()
                dismiss(animated: true, completion: nil)
            }catch{
                print(error)
                dismiss(animated: true, completion: nil)
            }
        }
        else{
            dismiss(animated: true, completion: nil)
            
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
        //rowとcolumでデータを検索する設定をする
        let predicate = NSPredicate(format:"(row == %d && colum == %d)", row, section )
        //データの取得のリクエストを作る
        fetchRequest.predicate = predicate
        //データを取得する
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            //データの書き換えをおこなう（複数ある場合を想定してfor文になっている）
            for i in 0..<fetchData.count{
                //各項目のデータを書き換える
                class_name.title = fetchData[i].title
            }
            } else {
                class_name.title = "新規作成"
            }
        
        //角丸に
          buttan_input.layer.cornerRadius = 5.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


