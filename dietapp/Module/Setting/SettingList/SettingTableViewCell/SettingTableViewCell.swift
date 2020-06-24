//
//  SettingTableViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/19.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var settingListLabel: UILabel!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - PrivateMethod
    
    func setSettingCell(_ settingName: String) {
        
        let colorSet = ColorManager.singletonColorManager.colorSet
        
        self.backgroundColor = colorSet.background
        self.settingListLabel.backgroundColor = .clear
        self.settingListLabel.textColor = colorSet.bodyText
        self.settingListLabel.text = "   \(settingName)"
    }
    
}
