//
//  ListCell.swift
//  SimpsonsCharacterViewer
//
//  Created by Sai Goutham  on 27/01/19.
//  Copyright © 2019 DataQ. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
