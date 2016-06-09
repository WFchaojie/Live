//
//  TableViewCell.swift
//  Live
//
//  Created by 武超杰 on 16/6/6.
//  Copyright © 2016年 武超杰. All rights reserved.
//

import UIKit



class HomeCell: UITableViewCell {

    var picString : String?
    var pic: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        if pic==nil {
            pic = UIImageView(frame: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
            self.addSubview(pic!)
            pic?.contentMode = UIViewContentMode.ScaleAspectFill
            pic?.clipsToBounds = true
            pic?.userInteractionEnabled = true
        }
        if (picString != nil) {
            let url = NSURL(string: picString!)
            pic?.sd_setImageWithURL(url)
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
