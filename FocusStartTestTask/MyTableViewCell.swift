//
//  MyTableViewCell.swift
//  FocusStartTestTask
//
//  Created by Max on 16.03.2021.
//  Copyright © 2021 Max. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var titleNoteLabel: UILabel!
    @IBOutlet weak var textNoteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
