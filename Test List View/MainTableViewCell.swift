//
//  MainTableViewCell.swift
//  Test List View
//
//  Created by Alexsander  on 10/30/15.
//  Copyright © 2015 Alexsander Khitev. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet 
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var colorButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
