//
//  TimingBillList.swift
//  Bill3
//
//  Created by superMT on 16/3/21.
//  Copyright © 2016年 superMT. All rights reserved.
//

import UIKit

class TimingBillList: UITableViewController {
    var db:SQLiteDB!
    @IBOutlet weak var picker1: UIDatePicker!
    @IBOutlet weak var picker2: UIDatePicker!
    @IBAction func TimeChanging(sender: UIDatePicker) {
        TimingBillList.ShareList.removeAll()
        loadData()
        tableView.reloadData()
    }
    static var ShareList = [Bill]()
    override func viewDidLoad() {
        self.tableView!.registerNib(UINib(nibName:"ProtoCell", bundle:nil),forCellReuseIdentifier:"ProtoCell")
        picker1.date =  NSDate(timeInterval: -30*24*60*60, sinceDate: NSDate())
        db = SQLiteDB.sharedInstance();
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = dateFormatter.stringFromDate(picker1.date)
        let date2 = dateFormatter.stringFromDate(picker2.date)
        print(date1)
        let data = db.query("select * from bill  where date between '\(date1)' AND '\(date2)' Order By date")
        print("select * from bill  where date between '\(date1)' AND '\(date2)' Order By date")
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
                TimingBillList.ShareList.append(temp)
            }
        }
    
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TimingBillList.ShareList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ProtoCell = tableView.dequeueReusableCellWithIdentifier("ProtoCell", forIndexPath: indexPath) as! ProtoCell;
        //let v1 = MonthList[indexPath.row]
        let fillin = TimingBillList.ShareList[indexPath.row]
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
}
