//
//  MonthBillList.swift
//  Bill3
//
//  Created by superMT on 16/3/13.
//  Copyright © 2016年 superMT. All rights reserved.
//

import UIKit

class MonthBillList: UITableViewController {
    
    @IBOutlet var MonthList: UITableView!
    internal static var AllListData  = [Bill]();
    var db:SQLiteDB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.registerNib(UINib(nibName:"ProtoCell", bundle:nil),forCellReuseIdentifier:"ProtoCell")
        db = SQLiteDB.sharedInstance();
        db.execute("create table if not exists bill (note TEXT, date DATE, tag TEXT, type TEXT, money DOUBLE)")
        //MonthBillList.AllListData.append(MonthBillList.temp)
        //AllListData.append(Bill());
        MonthBillList.AllListData.removeAll()
        
        loadData()
    }
    
    func loadData(){
        let data = db.query("select * from bill")
        if data.count > 0 {
            print(data[0])
            for bill in data{
                var temp = Bill();
                print(bill["note"] as? String)
                temp.note = (bill["note"] as? String)!
                temp.money = (bill["money"] as? Double)!
                temp.tag = (bill["tag"] as? String)!
                temp.date = (bill["date"] as? NSDate)!
                temp.type = (bill["type"] as? String)!
                MonthBillList.AllListData.append(temp)
            }
        }
    }
    
    func saveBill(temp:Bill){
        let note = temp.note;
        let date = temp.date;
        let tag = temp.tag;
        let money = temp.money;
        let type = temp.type;
        let sql = "insert into bill (note,date,tag,type,money) values('\(note)','\(date)','\(tag)','\(type)','\(money)')"
        let result = db.execute(sql)
        print(result);
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
        return MonthBillList.AllListData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ProtoCell = tableView.dequeueReusableCellWithIdentifier("ProtoCell", forIndexPath: indexPath) as! ProtoCell;
        //let v1 = MonthList[indexPath.row]
        let fillin = MonthBillList.AllListData[indexPath.row]
        // Configure the cell...
        cell.Type.text = fillin.type
        cell.notes.text = fillin.note
        cell.Money.text = "\(fillin.money)"
        let formater = NSDateFormatter();
        formater.dateStyle = NSDateFormatterStyle.MediumStyle
        let temp = formater.stringFromDate(fillin.date)
        cell.Time.text = temp
        /*if v1.checked{
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }*/
        
        return cell
    }
    
    override func tableView(tableView: UITableView ,didSelectRowAtIndexPath indexPath: NSIndexPath){
        //tableView.reloadData()
    }
    

    @IBAction func backToMonth(segue : UIStoryboardSegue){
        tableView.reloadData()
        saveBill(MonthBillList.AllListData[MonthBillList.AllListData.count-1])
        /*let temp = Bill();
        let note = temp.note;
        let date = temp.date;
        let tag = temp.tag;
        let money = temp.money;
        let type = temp.type;
        let sql = "insert into bill (note,date,tag,type,money) values('\(note)','\(date)','\(tag)','\(type)','\(money)')"
        let result = db.execute(sql)
        print(result);*/
        //var db:SQLiteDB!
    }
}
