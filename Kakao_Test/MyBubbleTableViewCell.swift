//
//  MyBubbleTableViewCell.swift
//  Kakao_Test
//
//  Created by synlex on 2018. 4. 14..
//  Copyright © 2018년 synlex. All rights reserved.
//

import UIKit

class MyBubbleTableViewCell: UITableViewCell {

    @IBOutlet weak var bubbleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
