//
//  ProtoCell.swift
//  Bill3
//
//  Created by superMT on 16/3/14.
//  Copyright © 2016年 superMT. All rights reserved.
//

import UIKit

class ProtoCell: UITableViewCell {

    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Type: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var Money: UILabel!
    @IBOutlet weak var Tags: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func ChangeItems(sender: UIButton) {
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
