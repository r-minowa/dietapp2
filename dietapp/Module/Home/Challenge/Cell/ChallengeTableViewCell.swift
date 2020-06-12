//
//  ChallengeTableViewCell.swift
//  dietapp
//
//  Created by 蓑輪 竜輝 on 2020/05/18.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
        
    // MARK: - IBOutlet
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var namePartsView: UIView!
    @IBOutlet weak var secSetView: UIView!
    
    @IBOutlet weak var trainingNameLabel: UILabel!
    @IBOutlet weak var partsLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var batuLabel: UILabel!
    @IBOutlet weak var achievementLabel: UILabel!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        self.mainView.layer.cornerRadius = 5
        self.mainView.clipsToBounds = true
        
        self.namePartsView.backgroundColor = UIColor(white:0.5, alpha:1.0)
        self.secSetView.backgroundColor = UIColor(white:0.9, alpha:1.0)
        self.achievementLabel.isHidden = true
        self.achievementLabel.backgroundColor = UIColor(white:0.5, alpha:0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - PrivateMethod
    
    func setChallengeString(_ challenge: Training, _ level: Training.Level) {
        let detail = challenge.details.filter{ $0.level == level }.first
        
        var parts: String = ""
        for count in 0..<challenge.parts.count {
            parts += "\(challenge.parts[count].rawValue) "
        }
        
        var sec = 0
        var set = 0
        
        if let unwrapDetail = detail {
            sec = unwrapDetail.secOfSets
            set = unwrapDetail.countOfSets
        }
        
        self.trainingNameLabel.text! = challenge.name.rawValue
        self.partsLabel.text = parts
        self.secLabel.text = String(sec)
        self.setLabel.text = String(set)        
    }
    
    func setAchievementCell() {
        self.achievementLabel.isHidden = false
    }
}

/*
 ・難易度low内容全表示（オプショナル）
 challenges[randomCount].details[0]
 ・low
 challenges[randomCount].details[0].level!
 
 腹筋：
 セット数×回数
 1セットの目安は--回です。
 
 */
