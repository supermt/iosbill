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
        BillList.actionType = "创建"
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
            //BillList.AllListData.append(temp)
            if validateInput(){
                BillList.AllListData.append(temp)
            }
            else {
            }
            //MonthBillList().saveBill(temp);
        }
        else {
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    func validateInput()->Bool{
        
        
        if Notes.text == "" {
            if Tag.text == "" {
                if MoneyCount.text == "" {
                    if (MoneyCount.text! as NSString).doubleValue == 0.0{
                        return false;
                    }
                }
            }
        }
        return true;
    }

}


class ModifyBill: UIViewController {
    var temp = Bill();
    
    
    //BillList.AllListData[BillList.cur_row]
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
            print("支出")
        }
        else {
            temp.type = "收入"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temp.note = BillList.AllListData[BillList.cur_row].note
        temp.tag = BillList.AllListData[BillList.cur_row].tag
        temp.money = BillList.AllListData[BillList.cur_row].money
        temp.date = BillList.AllListData[BillList.cur_row].date
        temp.type = BillList.AllListData[BillList.cur_row].type
        
        BillList.actionType = "修改"
        timePicker.date = BillList.AllListData[BillList.cur_row].date
        MoneyCount.text = String.init(BillList.AllListData[BillList.cur_row].money)
        Notes.text = BillList.AllListData[BillList.cur_row].note
        Tag.text = BillList.AllListData[BillList.cur_row].tag
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        BillList.AllListData[BillList.cur_row].date = timePicker.date
        BillList.AllListData[BillList.cur_row].money = (MoneyCount.text! as NSString).doubleValue
        BillList.AllListData[BillList.cur_row].note = Notes.text!
        BillList.AllListData[BillList.cur_row].tag = Tag.text!
    }
    
}

