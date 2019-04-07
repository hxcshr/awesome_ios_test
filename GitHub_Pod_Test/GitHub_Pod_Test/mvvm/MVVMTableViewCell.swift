
//
//  MVVMTableViewCell.swift
//  GitHub_Pod_Test
//
//  Created by 何学成 on 2019/4/7.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import Cartography


class MVVMTableViewCell: UITableViewCell {
    
    let img = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(img)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(timeLabel)
        
        img.contentMode = UIView.ContentMode.scaleAspectFit
        
        constrain(contentView,img) { (contentView, img) in
            img.left == contentView.left + 16
            img.top == contentView.top + 16
            img.width == 80
            img.height == 80
            
        }
        
        constrain(contentView, titleLabel, img) { (contentView,titleLabel,img) in
            titleLabel.left == img.right + 8
            titleLabel.top == img.top
            titleLabel.width == UIScreen.main.bounds.size.width - 120
        }
        
        constrain(subtitleLabel, titleLabel) { (subtitleLabel,titleLabel) in
            subtitleLabel.left == titleLabel.left
            subtitleLabel.top == titleLabel.bottom + 8
            subtitleLabel.width == titleLabel.width
        }
        
        constrain(img,timeLabel,titleLabel,contentView) { (img,timeLabel,titleLabel,contentView) in
            timeLabel.left == titleLabel.left
            timeLabel.bottom == img.bottom
            timeLabel.width == titleLabel.width
            timeLabel.bottom == contentView.bottom - 16
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(model: MVVMModel) {
        img.setImageWith(URL(string: model.picUrl!), placeholder: nil)
        titleLabel.text = model.title
        timeLabel.text = model.ctime
        subtitleLabel.text = model.description
    }

}
