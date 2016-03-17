//
//  AddBill.swift
//  Bill3
//
//  Created by superMT on 16/3/16.
//  Copyright © 2016年 superMT. All rights reserved.
//

import UIKit

class AddBill: UIViewController {
    var temp = Bill()
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var DoneBtn: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var MoneyCount: UITextField!
    @IBOutlet weak var Notes: UITextField!
    @IBOutlet weak var Tag: UITextField!
    
//    
//    @IBAction func NoteEditing(sender: UITextField) {
//        temp.note = sender.text!
//    }
//    @IBAction func DateEditing(sender: UIDatePicker) {
//        temp.date = sender.date
//    }
//    @IBAction func MoneyEditing(sender: UITextField) {
//        temp.money = Double.init(sender.text!)!
//        //testLabel.text = "\(MonthBillList.temp.money)"
//    }
    @IBAction func TypeChanging(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1{
            temp.type = "支出"
        }
        else {
            temp.type = "收入"
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as! NSObject == DoneBtn {
            temp.date = timePicker.date
            temp.money = (MoneyCount.text! as NSString).doubleValue
            temp.note = Notes.text!
            temp.tag = Tag.text!
            MonthBillList.AllListData.append(temp)
        }
        else {
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
