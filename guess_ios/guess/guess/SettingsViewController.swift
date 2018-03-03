//
//  SettingsViewController.swift
//  guess
//
//  Created by Kio Yamada on 2018/03/03.
//  Copyright © 2018年 O_Kenta. All rights reserved.
//

import UIKit
import CoreData


class SettingsViewController: UIViewController {

    //確認用
    @IBAction func check(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Setting> = Setting.fetchRequest()
        let setting = Setting(context:context)
        //データを追加
        print(setting.no_absence)

    }
    
    @IBOutlet weak var noabsence_field: UITextField!
    
    
    @IBAction func input_noabsence(_ sender: UIButton) {
        //入力された文字列のインプット
        let noabsence_count = noabsence_field.text!
        //入力されていなかった場合は処理はおこなわずに、戻る
        if noabsence_count == "" {
            dismiss(animated: true, completion: nil)
            return
    
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Setting> = Setting.fetchRequest()
        
        //過去にデータが作成されていた場合
        print("欠席可能数更新！！！")

        
        do{
            print("新しくついか!!")
            //データベース全体を取得
            let setting = Setting(context:context)
            //データを追加
            let noabsence_count_num = Int64(noabsence_count)!
            setting.no_absence = Int64(noabsence_count_num)
            print(noabsence_count_num)
            try context.save()
            dismiss(animated: true, completion: nil)
        }catch{
            print(error)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
