//
//  TableViewCell.swift
//  testApp
//
//  Created by Yermakov Anton on 02.06.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
