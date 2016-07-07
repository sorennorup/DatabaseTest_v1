//
//  customCellTableViewCell.swift
//  UUWiki2
//
//  Created by Søren on 16/03/15.
//  Copyright (c) 2015 Søren. All rights reserved.
//

import UIKit

class customCellTableViewCell: UITableViewCell {

    @IBOutlet weak var begrebLabel: UILabel!
    
    @IBOutlet weak var fuldbetegnelseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
   
}
