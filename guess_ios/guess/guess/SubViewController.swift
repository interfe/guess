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
    
    var select_name = "やまだ";
    var section = 0;
    var row = 0;
    
    
    
///授業の情報を入力する
@IBAction func class_input(_ sender: UIButton) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let lesson = Lesson(context:context)
        
        let lesson_name = class_input.text
        if lesson_name == "" {
            dismiss(animated: true, completion: nil)
            return
        }

        lesson.title = lesson_name
        lesson.row = Int64(row)
        lesson.colum = Int64(section)
        do{
            try context.save()
            print("input!!")
            dismiss(animated: true, completion: nil)
            return
        }catch{
            print(error)
            dismiss(animated: true, completion: nil)
            return
        }
    }
    
    ///削除ボタン
    @IBAction func delete_button(_ sender: UIButton) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
                let context = delegate.persistentContainer.viewContext
                let fetchRequest:NSFetchRequest<Lesson> = Lesson.fetchRequest()
//                let predicate = NSPredicate(format:"%K = %d","colum",0)
//                fetchRequest.predicate = predicate
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
        
        class_name.title = select_name;
        
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
