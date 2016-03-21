//
//  MonthBillList.swift
//  Bill3
//
//  Created by superMT on 16/3/13.
//  Copyright © 2016年 superMT. All rights reserved.
//

import UIKit

class BillList: UITableViewController {
    
    @IBOutlet weak var DeleteBTN: UIBarButtonItem!
    @IBOutlet var MonthList: UITableView!
    @IBOutlet weak var ModifyBTN: UIBarButtonItem!
    internal static var AllListData  = [Bill]();
    var db:SQLiteDB!
    static var cur_row = 0;
    static var actionType = "创建";
    var page = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.registerNib(UINib(nibName:"ProtoCell", bundle:nil),forCellReuseIdentifier:"ProtoCell")
        db = SQLiteDB.sharedInstance();
        db.execute("create table if not exists bill (note TEXT, date DATE, tag TEXT, type TEXT, money DOUBLE)")
        //MonthBillList.AllListData.append(MonthBillList.temp)
        //AllListData.append(Bill());
        BillList.AllListData.removeAll()
        loadData()
    }
    
    func loadData(){
        let data = db.query("select * from bill Order By date limit 100 offset \(page)")
        if data.count > 0 {
            //print(data[0])
            for bill in data{
                let temp = Bill();
                //print(bill["note"] as? String)
                temp.note = (bill["note"] as? String)!
                temp.money = (bill["money"] as? Double)!
                temp.tag = (bill["tag"] as? String)!
                temp.date = (bill["date"] as? NSDate)!
                temp.type = (bill["type"] as? String)!
                BillList.AllListData.append(temp)
            }
        }
    }
    
    func saveBill(temp:Bill){
        let note = temp.note;
        let date = temp.date;
        let tag = temp.tag;
        let money = temp.money;
        let type = temp.type;
        let sql = "INSERT INTO bill (note,date,tag,type,money) values('\(note)','\(date)','\(tag)','\(type)','\(money)')"
        let result = db.execute(sql)
        print(result);
    }

    @IBAction func DeleteSelect(sender: UIBarButtonItem) {
        DBdelete(BillList.AllListData[BillList.cur_row]);
        BillList.AllListData.removeAtIndex(BillList.cur_row)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BillList.AllListData.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print(indexPath.row);
        BillList.cur_row = indexPath.row;
        if BillList.cur_row > BillList.AllListData.count {
            ModifyBTN.enabled = false;
            DeleteBTN.enabled = false;
        }
        else {
            ModifyBTN.enabled = true;
            DeleteBTN.enabled = true;
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ProtoCell = tableView.dequeueReusableCellWithIdentifier("ProtoCell", forIndexPath: indexPath) as! ProtoCell;
        //let v1 = MonthList[indexPath.row]
        let fillin = BillList.AllListData[indexPath.row]
        // Configure the cell...
        cell.Type.text = fillin.type
        cell.notes.text = fillin.note
        cell.Money.text = "\(fillin.money)"
        let formater = NSDateFormatter();
        formater.dateStyle = NSDateFormatterStyle.MediumStyle
        let temp = formater.stringFromDate(fillin.date)
        cell.Time.text = temp
        cell.Tags.text = fillin.tag
        /*if v1.checked{
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }*/
        
        return cell
    }
    

    @IBAction func backToMonth(segue : UIStoryboardSegue){
        if (BillList.actionType == "创建"){
            print("创建完成")
            if (segue.sourceViewController as! AddBill).validateInput(){
                saveBill((segue.sourceViewController as! AddBill).temp)
            }
        }
        else {
            print("修改完成")
            //DBUpdate(BillList.AllListData[BillList.cur_row])
            DBdelete((segue.sourceViewController as! ModifyBill).temp)
            saveBill(BillList.AllListData[BillList.cur_row])
//            if (segue.sourceViewController as! ModifyBill).validateInput(){
//                saveBill((segue.sourceViewController as! ModifyBill).temp)
//            }
        }
        
        tableView.reloadData()
        
    }
    
    func DBUpdate(old:Bill,temp:Bill)->Int32{
        let note = temp.note;
        let date = temp.date;
        let tag = temp.tag;
        let sql = "UPDATE bill SET note = '\(note)' , date = '\(date)', tag = '\(tag)' WHERE ;"
        let result = db.execute(sql)
        return result
    }
    
    func DBdelete(temp:Bill)->Int32{
        let note = temp.note;
        let date = temp.date;
        let tag = temp.tag;
        let sql = "DELETE FROM bill WHERE note = '\(note)' AND date = '\(date)' AND tag = '\(tag)'"
        let result = db.execute(sql)
        return result
    }
}
