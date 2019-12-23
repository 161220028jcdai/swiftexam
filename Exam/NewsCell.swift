//
//  NewsCell.swift
//  Exam
//
//  Created by Apple on 2019/12/23.
//  Copyright © 2019 Exam. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var dateL: UILabel!
    
    @IBOutlet weak var hotImageV: UIImageView!
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    var news: News? {
        didSet {
            nameL.text = news?.title
            dateL.text = news?.date
            if (news?.count ?? 0) >= 1000 {
                imageWidth.constant = 40
            } else {
                imageWidth.constant = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
