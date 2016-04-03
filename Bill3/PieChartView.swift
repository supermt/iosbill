//
//  ViewController.swift
//  Bill3
//
//  Created by superMT on 16/3/13.
//  Copyright © 2016年 superMT. All rights reserved.
//

import UIKit

class PieChartItem {
    var color: UIColor
    var value: Double
    
    init(value: Double = 0, color: UIColor) {
        self.color = color
        self.value = value
    }
}


class RootView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

class paint: UIView{
    
    var db:SQLiteDB!
    var items: [PieChartItem] = [PieChartItem]()
    var column: [NSString] = [NSString]()
    var sum: Double = 0
    
    func loadData(){
        items.removeAll()
        db = SQLiteDB.sharedInstance();
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = dateFormatter.stringFromDate(TimingBillList.date1)
        let date2 = dateFormatter.stringFromDate(TimingBillList.date2)
        let data = db.query("select SUM(money) as Sum,tag from bill  where date between '\(date1)' AND '\(date2)' Group By date")
        var count = CGFloat.init(integerLiteral: 0);
        if data.count > 0{
            for a in data {
                print(a);
                count = (count + 100 )%255;
                items.append(PieChartItem(value: (a["Sum"] as? Double)!,color: UIColor(red: count/255, green: ((186+count)%255)/255, blue: ((89+count)%255)/255, alpha: 1)))
                column.append((a["tag"] as? NSString)!)
                sum += (a["Sum"] as? Double)!
            }//load data
        }
        
        items = items.sort { (a, b) -> Bool in
            if a.value > b.value {return true}
            else {return false}
        }
        

    }
    
    func clearItems() {
        items.removeAll(keepCapacity: true)
        sum = 0
    }
    
    func addItem(value: Double, color: UIColor) {
        let item = PieChartItem(value: value, color: color)
        items.append(item)
        sum += value
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadData()
        /*
        for item in items{
            addItem(item.value,color: item.color)
        }*/
        
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!;//获取画笔上下文
        CGContextSetAllowsAntialiasing(context,false) //抗锯齿设置
        //画圆初始化
        let raduis = CGFloat.init(150)
        var startX=(rect.width/2.0)
        let fullRound = (2*M_PI)
        var cur_angle = 0.0;
        var startY=raduis+70;
        
        for a in items{
            //print(a.value)
            CGContextSetFillColorWithColor(context,a.color.CGColor);//填充颜色
            CGContextMoveToPoint(context, startX, startY);
            
            CGContextAddArc(context, startX, startY, raduis, CGFloat.init(cur_angle), CGFloat.init(cur_angle)+CGFloat.init((a.value/sum)*fullRound) , 0)
            CGContextDrawPath(context, CGPathDrawingMode.Fill);//绘制填充
            CGContextFillPath(context)
            cur_angle+=(a.value/sum)*fullRound;
        }
        
        startY = startY + raduis;
        for var i = 0 ;i < 5 && i < items.count; i++ {
            startX = CGFloat.init(20)
            startY = startY + 40;
            CGContextSetFillColorWithColor(context,items[i].color.CGColor);//填充颜色
            CGContextMoveToPoint(context, startX, startY);
            CGContextAddRect(context, CGRect.init(x: startX, y: startY, width: 30, height: 30))
            CGContextDrawPath(context, CGPathDrawingMode.Fill);//绘制填充
            CGContextFillPath(context)
            startX = startX + 40
            let str:NSString = "\(column[i]):\(items[i].value)"
            str.drawAtPoint(CGPoint.init(x: startX, y: startY), withAttributes: nil)
            
        }
        
        /*
        CGContextSetFillColorWithColor(context,UIColor.redColor().CGColor);//填充颜色
        CGContextAddArc(context, startX, startY, raduis, 0, angel, 0)
        CGContextDrawPath(context, CGPathDrawingMode.Fill);//绘制填充
        */
        CGContextStrokePath(context)//关闭路径
    }
}
