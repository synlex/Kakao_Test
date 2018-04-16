//
//  YourBubbleTableViewCell.swift
//  Kakao_Test
//
//  Created by synlex on 2018. 4. 14..
//  Copyright © 2018년 synlex. All rights reserved.
//

import UIKit

class YourBubbleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bubbleText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 프로필 이미지를 동그랗게 표현
        img.layer.cornerRadius = img.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
