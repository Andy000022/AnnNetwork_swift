//
//  TableViewCell.swift
//  AnnNetworkTool
//
//  Created by iSolar on 2017/8/14.
//  Copyright © 2017年 nothing. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    
    var model : ListModel? {
        
        didSet {
            
            let url = model?.images[0] as! String
            
            let imgUrl = NSURL.init(string: url)
            
            icon.sd_setImage(with: imgUrl! as URL, completed: nil)
            
            titleL.text = model?.title
            
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
