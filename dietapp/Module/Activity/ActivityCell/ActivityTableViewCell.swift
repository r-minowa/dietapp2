//
//  ActivityTableViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/06/09.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

     let colorManager = ColorManager().colorSet
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - PrivateMethod
    
    func setCell(_ name: String) {
        self.backgroundColor = self.colorManager.background
        self.trainingNameLabel.backgroundColor = .clear
        self.trainingNameLabel.tintColor  = self.colorManager.bodyText
        self.trainingNameLabel.text = "   \(name)"
    }
    
}
